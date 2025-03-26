//
//  AddMeetingSheet.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct AddMeetingSheet: View {
    @Binding var meetings: [MeetingModel]

    @State private var topic: String = ""
    @State private var date: Date = Date()
    @State private var rules: String = ""
    @State private var goals: String = ""
    @State private var conclusion: String = ""
    @State private var favorite: Bool = false
    @State private var background: String = "image5"

    @State private var isEditingRules = false
    @State private var isEditingGoals = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Add Meeting")
                    .font(.title.bold())
                    .padding(.top, 10)

                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Meeting Topic")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter topic", text: $topic)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }
                }

                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Rules")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: { isEditingRules.toggle() }) {
                                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                    .foregroundColor(.blue)
                            }
                        }
                        TextEditor(text: $rules)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                .fullScreenCover(isPresented: $isEditingRules) {
                    ExpandedTextEditor(title: "Edit Rules", text: $rules)
                }

                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Goals")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: { isEditingGoals.toggle() }) {
                                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                    .foregroundColor(.blue)
                            }
                        }
                        TextEditor(text: $goals)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                .fullScreenCover(isPresented: $isEditingGoals) {
                    ExpandedTextEditor(title: "Edit Goals", text: $conclusion)
                }

                Button(action: saveMeeting) {
                    Text("Save Meeting")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }

    func saveMeeting() {
        let newMeeting = MeetingModel(
            topic: topic,
            date: date,
            rules: rules,
            goals: goals,
            conclusion: conclusion,
            favorite: favorite,
            sessions: [],
            background: background
        )
        meetings.append(newMeeting)
        dismiss()
    }

    @ViewBuilder
    private func inputCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack {
            content()
                .padding()
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        }
    }
}

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
    @Previewable @State var meetings: [MeetingModel] = (1...50).map { i in
        let randomSuffix = String((0..<Int.random(in: 10...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
        return MeetingModel(
            topic: "Meeting \(i) \(randomSuffix)",
            date: Date().addingTimeInterval(Double(i) * 86400),
            rules: "Rules",
            goals: "Goals",
            conclusion: "Conclusion of meeting \(i)",
            favorite: Bool.random(),
            sessions: [],
            background: "image 7"
        )
    }
    AddMeetingSheet(meetings: $meetings)
}
