//
//  NoteView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct NoteView: View {
    @Binding var meetings: [MeetingModel]
    
    let id: UUID
    let title: String
    
    @State private var isEditing = false
    
    var body: some View {
        
        let index = meetings.firstIndex(where: { $0.id == id }) ?? 0
        
        Form {
            Section(header: Text("Enter \(title)").bold()) {
                HStack {
                    Text("Tap to expand")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: { isEditing.toggle() }) {
                        Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                            .foregroundColor(.blue)
                    }
                }
                TextEditor(text: Binding(
                    get: {
                        title == "Rules" ? meetings[index].rules :
                        title == "Goals" ? meetings[index].goals :
                        title == "Conclusion" ? meetings[index].conclusion : ""
                    },
                    set: { newValue in
                        if title == "Rules" {
                            meetings[index].rules = newValue
                        } else if title == "Goals" {
                            meetings[index].goals = newValue
                        } else if title == "Conclusion" {
                            meetings[index].conclusion = newValue
                        }
                    }
                ))
                .frame(minHeight: 200)
                .cornerRadius(8)
                .padding(.vertical, 5)
            }
        }
        .fullScreenCover(isPresented: $isEditing) {
            ExpandedTextEditor(title: title, text: Binding(
                get: {
                    title == "Rules" ? meetings[index].rules :
                    title == "Goals" ? meetings[index].goals :
                    title == "Conclusion" ? meetings[index].conclusion : ""
                },
                set: { newValue in
                    if title == "Rules" {
                        meetings[index].rules = newValue
                    } else if title == "Goals" {
                        meetings[index].goals = newValue
                    } else if title == "Conclusion" {
                        meetings[index].conclusion = newValue
                    }
                }
            ))
        }
    }
}

#Preview {
    @Previewable @State var meetings: [MeetingModel] = (1...50).map { i in
        let randomSuffix = String((0..<Int.random(in: 10...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
        return MeetingModel(
            topic: "Meeting \(i) \(randomSuffix)",
            date: Date().addingTimeInterval(Double(i) * 86400),
            goals: "Goals",
            rules: "Rules",
            conclusion: "Conclusion of meeting \(i)",
            favorite: Bool.random(),
            background: "image 7",
            sessions: [
                SessionModel(
                    subTopic: "No Data",
                    name: "No Data",
                    role: "No Data",
                    duration: 60,
                    notes: "No Data",
                    timeLeft: 60
                )
            ]
        )
    }
    NoteView(meetings: $meetings, id: meetings[0].id, title: "Test")
}

