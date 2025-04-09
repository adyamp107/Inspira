////
////  AddSessionView.swift
////  Inspira
////
////  Created by Adya Muhammad Prawira on 06/04/25.
////
//
//import SwiftUI
//
//struct AddSessionView: View {
//    @Environment(\.modelContext) private var context
//    
//    @Bindable var meeting: Meeting
//
//    @State private var order: Int = 0
//    @State private var subTopic: String = ""
//    @State private var name: String = ""
//    @State private var duration: Double = 0
//    @State private var notes: String = ""
//    @State private var passedTime: Double = 0
//    
//    @State private var isEditingNotes = false
//    
//    @State private var selectedHours: Int = 0
//    @State private var selectedMinutes: Int = 0
//    @State private var selectedSeconds: Int = 0
//
//    let hoursRange = Array(0...5)
//    let minutesRange = Array(0...59)
//    let secondsRange = Array(0...59)
//    
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 40) {
//                VStack(spacing: 15) {
//                    Text("Add Session")
//                        .font(.title2.bold())                    
//                    VStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Session Subtopic")
//                            TextField("Enter subtopic", text: $subTopic)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                )
//                                .autocorrectionDisabled()
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                    }
//                    VStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Person in Charge")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            TextField("Enter name", text: $name)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                )
//                                .autocorrectionDisabled()
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                    }
//                    VStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            HStack {
//                                Text("Notes")
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                                Spacer()
//                                Button(action: { isEditingNotes.toggle() }) {
//                                    Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
//                                        .foregroundColor(.blue)
//                                }
//                            }
//                            TextEditor(text: $notes)
//                                .frame(height: 100)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                )
//                                .autocorrectionDisabled()
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                        .fullScreenCover(isPresented: $isEditingNotes) {
//                            ExpandedTextEditor(title: "Notes", text: $notes)
//                        }
//                    }
//                    VStack {
//                        VStack(alignment: .leading, spacing: 0) {
//                            Text("Duration")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            HStack {
//                                Picker("Hours", selection: $selectedHours) {
//                                    ForEach(hoursRange, id: \.self) { hour in
//                                        Text("\(hour) h").tag(hour)
//                                    }
//                                }
//                                .pickerStyle(.wheel)
//                                .frame(width: 80, height: 100)
//                                
//                                Picker("Minutes", selection:  $selectedMinutes) {
//                                    ForEach(minutesRange, id: \.self) { minute in
//                                        Text("\(minute) m").tag(minute)
//                                    }
//                                }
//                                .pickerStyle(.wheel)
//                                .frame(width: 80, height: 100)
//                                
//                                Picker("Seconds", selection:  $selectedSeconds) {
//                                    ForEach(secondsRange, id: \.self) { second in
//                                        Text("\(second) s").tag(second)
//                                    }
//                                }
//                                .pickerStyle(.wheel)
//                                .frame(width: 80, height: 100)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .onChange(of: selectedHours) {
//                                Task {
//                                    updateDuration()
//                                }
//                            }
//                            .onChange(of: selectedMinutes) {
//                                Task {
//                                    updateDuration()
//                                }
//                            }
//                            .onChange(of: selectedSeconds) {
//                                Task {
//                                    updateDuration()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color(UIColor.systemBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                }
//                .padding(.horizontal, 15)
//                Button("Save Session") {
//                    let maxOrderSession = meeting.sessions.map { $0.order }.max() ?? 0
//                    let order = maxOrderSession + 1
//                    meeting.sessions.append(
//                        Session(
//                            order: order,
//                            subTopic: subTopic,
//                            name: name,
//                            duration: duration,
//                            notes: notes,
//                            passedTime: passedTime
//                        )
//                    )
//                    dismiss()
//                }
//                .foregroundColor(Color.white)
//                .frame(width: 200)
//                .padding(.vertical, 8)
//                .background(Color.blue)
//                .cornerRadius(8)
//            }
//        }
//    }
//    private func updateDuration() {
//        duration = Double((selectedHours * 60 * 60) + (selectedMinutes * 60) + selectedSeconds)
//    }
//
//}
//
//#Preview {
//    AddSessionView(
//        meeting: Meeting(
//            order: 1,
//            topic: "Sprint Planning Meeting 2025 (Very Important)",
//            date: Date(),
//            descriptions: "Plan next sprint",
//            conclusion: "Next steps defined",
//            favorite: true,
//            background: "image1",
//            sessions: []
//        )
//    )
//}

//
//  AddSessionView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//
//
//import SwiftUI
//
//struct AddSessionView: View {
//    @Environment(\.modelContext) private var context
//    @Bindable var meeting: Meeting
//
//    @State private var order: Int = 0
//    @State private var subTopic: String = ""
//    @State private var name: String = ""
//    @State private var duration: Double = 0
//    @State private var notes: String = ""
//    @State private var passedTime: Double = 0
//
//    @State private var isEditingNotes = false
//
//    @State private var selectedHours: Int = 0
//    @State private var selectedMinutes: Int = 0
//    @State private var selectedSeconds: Int = 0
//
//    let hoursRange = Array(0...5)
//    let minutesRange = Array(0...59)
//    let secondsRange = Array(0...59)
//
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 15) {
//                Text("Add Session")
//                    .font(.title.bold())
//                    .padding(.top, 10)
//
//                textInputCard(title: "Session Subtopic", text: $subTopic, placeholder: "Enter subtopic")
//
//                textInputCard(title: "Person in Charge", text: $name, placeholder: "Enter name")
//
//                formCard {
//                    VStack(alignment: .leading, spacing: 8) {
//                        HStack {
//                            Text("Notes")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            Spacer()
//                            Button(action: { isEditingNotes.toggle() }) {
//                                Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
//                                    .foregroundColor(.accentColor)
//                            }
//                        }
//                        TextEditor(text: $notes)
//                            .frame(height: 100)
//                            .padding(8)
//                            .scrollContentBackground(.hidden)
//                            .background(Color(.tertiarySystemBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .autocorrectionDisabled()
//                    }
//                    .fullScreenCover(isPresented: $isEditingNotes) {
//                        ExpandedTextEditor(title: "Notes", allSessionNotes: "", text: $notes)
//                    }
//                }
//
//                formCard {
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Duration")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//
//                        HStack(spacing: 16) {
//                            durationPicker(title: "Hours", range: hoursRange, selection: $selectedHours, suffix: "h")
//                            durationPicker(title: "Minutes", range: minutesRange, selection: $selectedMinutes, suffix: "m")
//                            durationPicker(title: "Seconds", range: secondsRange, selection: $selectedSeconds, suffix: "s")
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: 100)
//                        .onChange(of: selectedHours) { updateDuration() }
//                        .onChange(of: selectedMinutes) { updateDuration() }
//                        .onChange(of: selectedSeconds) { updateDuration() }
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//
//                Button(action: saveSession) {
//                    Text("Save Session")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: 200)
//                        .padding(.vertical, 8)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//
//    private func saveSession() {
//        let maxOrderSession = meeting.sessions.map { $0.order }.max() ?? 0
//        let order = maxOrderSession + 1
//        meeting.sessions.append(
//            Session(
//                order: order,
//                subTopic: subTopic,
//                name: name,
//                duration: duration,
//                notes: notes,
//                passedTime: passedTime
//            )
//        )
//        dismiss()
//    }
//
//    private func updateDuration() {
//        duration = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds)
//    }
//
//    @ViewBuilder
//    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
//        VStack {
//            content()
//        }
//        .padding()
//        .background(Color(.secondarySystemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 15))
//        .shadow(color: Color.primary.opacity(0.05), radius: 4, x: 0, y: 2)
//    }
//
//    @ViewBuilder
//    private func textInputCard(title: String, text: Binding<String>, placeholder: String) -> some View {
//        formCard {
//            VStack(alignment: .leading, spacing: 8) {
//                Text(title)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                TextField(placeholder, text: text)
//                    .padding(10)
//                    .background(Color(.tertiarySystemBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                    .autocorrectionDisabled()
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func durationPicker(title: String, range: [Int], selection: Binding<Int>, suffix: String) -> some View {
//        Picker(title, selection: selection) {
//            ForEach(range, id: \.self) { value in
//                Text("\(value) \(suffix)").tag(value)
//            }
//        }
//        .pickerStyle(.wheel)
//        .frame(width: 80)
//    }
//}
//
//#Preview {
//    AddSessionView(
//        meeting: Meeting(
//            order: 1,
//            topic: "Sprint Planning Meeting 2025 (Very Important)",
//            date: Date(),
//            descriptions: "Plan next sprint",
//            conclusion: "Next steps defined",
//            favorite: true,
//            background: "image1",
//            sessions: []
//        )
//    )
//}


import SwiftUI

struct AddSessionView: View {
    @Environment(\.modelContext) private var context
    @Bindable var meeting: Meeting

    @State private var order: Int = 0
    @State private var subTopic: String = ""
    @State private var name: String = ""
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
            VStack(spacing: 12) {
                Text("Add Session")
                    .font(.title2.bold())
                    .padding(.top, 8)

                textInputCard(title: "Session Subtopic", text: $subTopic, placeholder: "Enter subtopic")
                textInputCard(title: "Person in Charge", text: $name, placeholder: "Enter name")

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
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .padding(6)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .scrollContentBackground(.hidden)
                            .autocorrectionDisabled()
                    }
                    .fullScreenCover(isPresented: $isEditingNotes) {
                        ExpandedTextEditor(title: "Notes", allSessionNotes: "", text: $notes)
                    }
                }

                formCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Duration")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        HStack(spacing: 12) {
                            durationPicker(title: "Hours", range: hoursRange, selection: $selectedHours, suffix: "h")
                            durationPicker(title: "Minutes", range: minutesRange, selection: $selectedMinutes, suffix: "m")
                            durationPicker(title: "Seconds", range: secondsRange, selection: $selectedSeconds, suffix: "s")
                        }
                        .frame(maxWidth: .infinity, maxHeight: 90)
                        .onChange(of: selectedHours) { updateDuration() }
                        .onChange(of: selectedMinutes) { updateDuration() }
                        .onChange(of: selectedSeconds) { updateDuration() }
                    }
                }

                Button(action: saveSession) {
                    Text("Save Session")
                        .foregroundColor(.white)
                        .frame(maxWidth: 180)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
                .padding(.top, 10)
            }
            .padding(.horizontal)
        }
    }

    private func saveSession() {
        let maxOrderSession = meeting.sessions.map { $0.order }.max() ?? 0
        let order = maxOrderSession + 1
        meeting.sessions.append(
            Session(
                order: order,
                subTopic: subTopic,
                name: name,
                duration: duration,
                notes: notes,
                passedTime: passedTime
            )
        )
        dismiss()
    }

    private func updateDuration() {
        duration = Double((selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds)
    }

    @ViewBuilder
    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack {
            content()
        }
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.primary.opacity(0.04), radius: 2, x: 0, y: 1)
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
    private func durationPicker(title: String, range: [Int], selection: Binding<Int>, suffix: String) -> some View {
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
    AddSessionView(
        meeting: Meeting(
            order: 1,
            topic: "Sprint Planning Meeting 2025 (Very Important)",
            date: Date(),
            descriptions: "Plan next sprint",
            conclusion: "Next steps defined",
            favorite: true,
            background: "image1",
            sessions: []
        )
    )
}
