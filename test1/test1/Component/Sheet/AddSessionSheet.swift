//
//  AddSessionSheet.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct AddSessionSheet: View {
    @Binding var meeting: MeetingModel
    
    @State private var subTopic: String = ""
    @State private var name: String = ""
    @State private var role: String = ""
    @State private var hours: Int = 0
    @State private var minutes: Int = 30
    @State private var notes: String = ""
    
    @State private var isEditingNotes = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Text("Add Session")
                    .font(.title.bold())
                    .padding(.top, 10)
                
                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sub Topic")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter sub topic", text: $subTopic)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Person in Charge")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter name", text: $name)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Role of the Person in Charge")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter role", text: $role)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Notes")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: { isEditingNotes.toggle() }) {
                                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                    .foregroundColor(.blue)
                            }
                        }
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                .fullScreenCover(isPresented: $isEditingNotes) {
                    ExpandedTextEditor(title: "Notes", text: $notes)
                }
                
                inputCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Duration")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Spacer()
                            Picker("Hours", selection: $hours) {
                                ForEach(0..<6, id: \..self) { hour in
                                    Text("\(hour) h").tag(hour)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 80, height: 100)
                            .clipped()
                            
                            Picker("Minutes", selection: $minutes) {
                                ForEach([0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55], id: \..self) { minute in
                                    Text("\(minute) m").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 80, height: 100)
                            .clipped()
                            
                            Spacer()
                        }
                    }
                }
                
                TextButton(
                    title: "Save Session",
                    color: .blue,
                    action: {
                        let newSession = SessionModel(
                            subTopic: subTopic,
                            name: name,
                            role: role,
                            duration: Double((hours * 60) + minutes) * 60,
                            notes: notes,
                            timeLeft: 0
                        )
                        meeting.sessions.append(newSession)
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
            background: "image7",
            sessions: []
        )
    }
    AddSessionSheet(meeting: $meetings[0])
}
