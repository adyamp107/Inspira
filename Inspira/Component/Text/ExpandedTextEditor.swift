//
//  ExpandedTextEditor.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

struct ExpandedTextEditor: View {
    let title: String
    let allSessionNotes: String
    @Binding var text: String
    @Environment(\.dismiss) var dismiss
    @State private var showCopiedAlert = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(10)
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
  
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Word count: \(text.split(separator: " ").count)")
                            Text("Character count: \(text.count)")
                        }

                        Spacer()

                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Label("Done Typing", systemImage: "keyboard.chevron.compact.down")
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .font(.footnote)
                .foregroundColor(.secondary)

                HStack {
                    Button(action: {
                        text = ""
                    }) {
                        Label("Clear", systemImage: "trash")
                            .padding(10)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        insertTemplate()
                    }) {
                        Label("Insert Template", systemImage: "doc.text")
                            .padding(10)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        UIPasteboard.general.string = text
                        showCopiedAlert = true
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .padding(10)
                            .background(Color.green.opacity(0.1))
                            .foregroundColor(.green)
                            .cornerRadius(8)
                    }
                }
                
                if title == "Conclusion" {
                    HStack {
                        Spacer()
                        Button(action: {
                            text += allSessionNotes
                        }) {
                            Text("Add Session Notes")
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        Spacer()
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showCopiedAlert) {
                Alert(title: Text("Copied!"), message: Text("Text has been copied to clipboard."), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func insertTemplate() {
        if title == "Descriptions" {
            text += "\n===================\n• Descriptions Template •\n===================\n\n• Background:\n\n• Goals:\n\n• Rules:\n\n• Stakeholders:\n\n• Notes:\n"
        } else if title == "Conclusion" {
            text += "\n==================\n• Conclusion Template •\n==================\n\n• Decision:\n\n• Key Points:\n\n• Next Steps:\n"
        } else {
            text += "\n==============\n• Notes Template •\n==============\n\n• Point 1:\n\n• Point 2:\n\n• Point 3:\n"
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    ExpandedTextEditor(title: "Conclusion", allSessionNotes: "sdcsdcs", text: $text)
}
