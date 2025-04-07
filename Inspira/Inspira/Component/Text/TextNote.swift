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
        VStack {
            if title == "Rules" {
                if meeting.rules.isEmpty {
                    VStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("No rules! 😁")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("You can add new rules! 👍")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                } else {
                    ScrollView {
                        Text(meeting.rules)
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
            } else if title == "Goals" {
                if meeting.goals.isEmpty {
                    VStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text("No goals! 😁")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("You can add new goals! 👍")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                } else {
                    ScrollView {
                        Text(meeting.goals)
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
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $isEditing) {
            ExpandedTextEditor(title: title, text: Binding(
                get: {
                    title == "Rules" ? meeting.rules :
                    title == "Goals" ? meeting.goals :
                    title == "Conclusion" ? meeting.conclusion : ""
                },
                set: { newValue in
                    if title == "Rules" {
                        meeting.rules = newValue
                    } else if title == "Goals" {
                        meeting.goals = newValue
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
            goals: "Plan next sprint",
            rules: "Follow agenda",
            conclusion: "Next steps defined",
            favorite: true,
            background: "image1",
            sessions: []
        ),
        title: "Goals"
    )
}
