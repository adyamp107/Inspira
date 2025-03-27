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
    @State private var background: String = ""
    @State private var sessions: [SessionModel] = []
    
    @State private var isEditingRules = false
    @State private var isEditingGoals = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
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
                    HStack(spacing: 8) {
                        Text("Date")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                    }
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
                    ExpandedTextEditor(title: "Goals", text: $goals)
                }

                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 20) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    .frame(width: 200, height: 200)
                                VStack {
                                    
                                }
                                .frame(width: 200, height: 200)
                                .background(
                                    Group {
                                        if FileManager.default.fileExists(atPath: background) {
                                            Image(uiImage: UIImage(contentsOfFile: background) ?? UIImage())
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 200, height: 200)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        } else {
                                            Text("Background")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                )
                            }
                            VStack(spacing: 20) {
                                CameraButton(imagePath: $background)
                                PicturePicker(imagePath: $background)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                TextButton(
                    title: "Save Meeting",
                    color: .blue,
                    action: {
                        let newMeeting = MeetingModel(
                            topic: topic,
                            date: date,
                            goals: goals,
                            rules: rules,
                            conclusion: conclusion,
                            favorite: favorite,
                            background: background,
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
                        meetings.append(newMeeting)
                        dismiss()
                    }
                )

                Spacer()
            }
            .padding()
        }
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
    AddMeetingSheet(meetings: $meetings)
}

