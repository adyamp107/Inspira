//
//  AddSessionView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

struct AddSessionView: View {
    @Environment(\.modelContext) private var context
    
    @Bindable var meeting: Meeting

    @State private var order: Int = 0
    @State private var subTopic: String = ""
    @State private var name: String = ""
    @State private var role: String = ""
    @State private var duration: Double = 0
    @State private var notes: String = ""
    @State private var passedTime: Double = 0
    
    @State private var isEditingNotes = false
    
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0

    let hoursRange = Array(0...5)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                VStack(spacing: 15) {
                    Text("Add Session")
                        .font(.title2.bold())                    
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Session Subtopic")
                            TextField("Enter subtopic", text: $subTopic)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Person in Charge")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Enter name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Role")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Enter role", text: $role)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Notes")
                                    .font(.subheadline)
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
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                        .fullScreenCover(isPresented: $isEditingNotes) {
                            ExpandedTextEditor(title: "Notes", text: $notes)
                        }
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Duration")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                Picker("Hours", selection: $selectedHours) {
                                    ForEach(hoursRange, id: \.self) { hour in
                                        Text("\(hour) h").tag(hour)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 80, height: 100)
                                
                                Picker("Minutes", selection:  $selectedMinutes) {
                                    ForEach(minutesRange, id: \.self) { minute in
                                        Text("\(minute) m").tag(minute)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 80, height: 100)
                                
                                Picker("Seconds", selection:  $selectedSeconds) {
                                    ForEach(secondsRange, id: \.self) { second in
                                        Text("\(second) s").tag(second)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 80, height: 100)
                            }
                            .onChange(of: selectedHours) {
                                Task {
                                    updateDuration()
                                }
                            }
                            .onChange(of: selectedMinutes) {
                                Task {
                                    updateDuration()
                                }
                            }
                            .onChange(of: selectedSeconds) {
                                Task {
                                    updateDuration()
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal, 15)
                Button("Save Session") {
                    let maxOrderSession = meeting.sessions.map { $0.order }.max() ?? 0
                    let order = maxOrderSession + 1
                    meeting.sessions.append(
                        Session(
                            order: order,
                            subTopic: subTopic,
                            name: name,
                            role: role,
                            duration: duration,
                            notes: notes,
                            passedTime: passedTime
                        )
                    )
                    dismiss()
                }
                .foregroundColor(Color.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }
    private func updateDuration() {
        duration = Double((selectedHours * 60 * 60) + (selectedMinutes * 60) + selectedSeconds)
    }

}

#Preview {
    AddSessionView(
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
        )
    )
}
