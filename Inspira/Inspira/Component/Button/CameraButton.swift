//
//  CameraButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import PhotosUI

struct CameraButton: View {
    @Binding var imagePath: String
    @State private var isShowingCamera = false
    
    var body: some View {
        Button(action: {
            isShowingCamera = true
        }) {
            Image(systemName: "camera")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(Color.blue)
        }
        .sheet(isPresented: $isShowingCamera) {
            ImagePicker(sourceType: .camera, imagePath: $imagePath)
        }
    }
}

#Preview {
    @Previewable @State var path: String = ""
    CameraButton(imagePath: $path)
}
