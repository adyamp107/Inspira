//
//  ExpandedTextEditor.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

struct ExpandedTextEditor: View {
    let title: String
    @Binding var text: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .navigationTitle(title)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    ExpandedTextEditor(title: "Test", text: $text)
}
