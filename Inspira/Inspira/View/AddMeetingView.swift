//
//  AddMeetingView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import SwiftData

struct AddMeetingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]

    @State private var order: Int = 0
    @State private var topic: String = ""
    @State private var date: Date = Date()
    @State private var goals: String = ""
    @State private var rules: String = ""
    @State private var conclusion: String = ""
    @State private var favorite: Bool = false
    @State private var background: String = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "orange", "blue"].randomElement()!
    @State private var sessions: [Session] = []
    
    @State private var isEditingGoals = false
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                VStack(spacing: 15) {
                    Text("Add Meeting")
                        .font(.title2.bold())
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Meeting Topic")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Enter topic", text: $topic)
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
                        HStack(spacing: 8) {
                            Text("Date")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Goals")
                                    .font(.subheadline)
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
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    .fullScreenCover(isPresented: $isEditingGoals) {
                        ExpandedTextEditor(title: "Goals", text: $goals)
                    }
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 20) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
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
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    )
                                }
                                VStack(spacing: 20) {
                                    CameraButton(imagePath: $background)
                                    PictureButton(imagePath: $background)
                                }
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 3)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 15)
                Button("Save Meeting") {
                    if let maxOrderMeeting = meetings.max(by: { $0.order < $1.order }) {
                        order = maxOrderMeeting.order + 1
                    }
                    context.insert(
                        Meeting(
                            order: order,
                            topic: topic,
                            date: date,
                            goals: goals,
                            rules: rules,
                            conclusion: conclusion,
                            favorite: favorite,
                            background: background,
                            sessions: []
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
}

#Preview {
    AddMeetingView()
}
