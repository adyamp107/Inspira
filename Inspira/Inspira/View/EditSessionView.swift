//
//  EditSessionView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI

struct EditSessionView: View {
    @Bindable var session: Session

    @State private var isEditingNotes = false

    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0

    @State private var selectedSound: String = ""
    @State private var customSoundName: String = ""
    @State private var useCustomSound: Bool = false

    let builtInSounds = ["radar_clone"]
    let hoursRange = Array(0...5)
    let minutesRange = Array(0...59)
    let secondsRange = Array(0...59)

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Edit Session")
                    .font(.title2.bold())
                    .padding(.top, 8)

                textInputCard(title: "Session Subtopic", text: $session.subTopic, placeholder: "Enter subtopic")
                textInputCard(title: "Person in Charge", text: $session.name, placeholder: "Enter name")

                formCard {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Notes")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            HStack(spacing: 10) {
                                Button(action: {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                }
                                .accessibilityLabel("Done Typing")
                                Button(action: { isEditingNotes.toggle() }) {
                                    Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }

                        TextEditor(text: $session.notes)
                            .frame(height: 100)
                            .padding(6)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .scrollContentBackground(.hidden)
                            .autocorrectionDisabled()
                    }
                    .fullScreenCover(isPresented: $isEditingNotes) {
                        ExpandedTextEditor(title: "Notes", allSessionNotes: "", text: $session.notes)
                    }
                }

                formCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Duration")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        HStack(spacing: 12) {
                            durationPicker("Hours", hoursRange, $selectedHours, "h")
                            durationPicker("Minutes", minutesRange, $selectedMinutes, "m")
                            durationPicker("Seconds", secondsRange, $selectedSeconds, "s")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 90)
                        .onChange(of: selectedHours) { updateDuration() }
                        .onChange(of: selectedMinutes) { updateDuration() }
                        .onChange(of: selectedSeconds) { updateDuration() }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            selectedHours = Int(session.duration / 3600)
            selectedMinutes = (Int(session.duration) % 3600) / 60
            selectedSeconds = Int(session.duration) % 60
        }
    }

    private func updateDuration() {
        session.duration = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds)
        if session.duration < session.passedTime {
            session.passedTime = 0
        }
    }

    @ViewBuilder
    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack { content() }
            .padding(10)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.primary.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private func textInputCard(title: String, text: Binding<String>, placeholder: String) -> some View {
        formCard {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField(placeholder, text: text)
                    .padding(8)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .autocorrectionDisabled()
            }
        }
    }

    @ViewBuilder
    private func durationPicker(_ title: String, _ range: [Int], _ selection: Binding<Int>, _ suffix: String) -> some View {
        Picker(title, selection: selection) {
            ForEach(range, id: \.self) { value in
                Text("\(value) \(suffix)").tag(value)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: 70)
    }
}

#Preview {
    EditSessionView(
        session: Session(
            order: 1,
            subTopic: "Sprint Planning Discussion",
            name: "Adya",
            duration: 8096,
            notes: "Sprint",
            passedTime: 0
        )
    )
}
