//
//  TextNote.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

struct TextNote: View {
    @Bindable var meeting: Meeting
    let title: String
    
    @State private var isEditing = false

    var body: some View {
        VStack(spacing: 16) {
            if title == "Descriptions" {
                if meeting.descriptions.isEmpty {
                    VStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("No descriptions! 😁")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("You can add new descriptions! 👍")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                } else {
                    ScrollView {
                        Text(meeting.descriptions)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .font(.body)
                    }
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            } else if title == "Conclusion" {
                if meeting.conclusion.isEmpty {
                    VStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("No conclusion! 😁")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("You can add new conclusion! 👍")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                } else {
                    ScrollView {
                        Text(meeting.conclusion)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .font(.body)
                    }
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
            }
            VStack {
                Button(
                    action: {
                        isEditing.toggle()
                    },
                    label: {
                        Text("Add \(title)")
                    }
                )
                .foregroundColor(Color.white)
                .frame(width: 200)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $isEditing) {
            let allSessionNotes = meeting.sessions
                .sorted(by: { $0.order > $1.order })
                .reduce("") { result, session in
                    if session.subTopic.isEmpty {
                        result + "\n• Untitled:\n\n\(session.notes)\n"
                    } else {
                        result + "\n• \(session.subTopic):\n\n\(session.notes)\n"
                    }
                }
            ExpandedTextEditor(title: title, allSessionNotes: allSessionNotes, text: Binding(
                get: {
                    title == "Descriptions" ? meeting.descriptions :
                    title == "Conclusion" ? meeting.conclusion : ""
                },
                set: { newValue in
                    if title == "Descriptions" {
                        meeting.descriptions = newValue
                    } else if title == "Conclusion" {
                        meeting.conclusion = newValue
                    }
                }
            ))
        }
    }
}

#Preview {
    TextNote(
        meeting: Meeting(
            order: 1,
            topic: "Sprint Planning Meeting 2025 (Very Important)",
            date: Date(),
            descriptions: "Plan next sprint",
            conclusion: "Next steps defined",
            favorite: true,
            background: "image1",
            sessions: []
        ),
        title: "Descriptions"
    )
}
