//
//  PictureButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import PhotosUI

struct PictureTextButton: View {
    @Binding var imagePath: String
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color.blue)
            Text("Select Image")
        }
        .onChange(of: selectedItem) {
            Task {
                if let item = selectedItem, let data = try? await item.loadTransferable(type: Data.self) {
                    let fileName = UUID().uuidString + ".jpg"
                    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
                    
                    do {
                        try data.write(to: fileURL)
                        imagePath = fileURL.path
                        selectedImage = UIImage(data: data)
                    } catch {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var path: String = ""
    PictureTextButton(imagePath: $path)
}
