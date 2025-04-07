//
//  MeetingView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import SwiftData

struct MeetingView: View {
    @Environment(\.modelContext) private var context

    @Bindable var meeting: Meeting
    
    @State private var shouldStopTimer = false
    @State private var selectedTab = 0
    @State private var showAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(
                Group {
                    let backgroundImage: String = meeting.background.isEmpty ?
                        ["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement()!
                        : meeting.background
                    if FileManager.default.fileExists(atPath: backgroundImage) {
                        ZStack {
                            Image(uiImage: UIImage(contentsOfFile: backgroundImage) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        }
                    } else if backgroundImage.contains("image") {
                        ZStack {
                            Image(backgroundImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        }
                    } else if backgroundImage == "orange" {
                        Color.orange
                    } else {
                        Color.blue
                    }
                }
            )

            VStack {
                HStack {
                    TextField("Enter topic", text: $meeting.topic)
                        .padding(.vertical, 5)
                        .background(Color.clear)
                    Spacer()
                }
                .padding(.horizontal)
                HStack(spacing: 20) {
                    DatePicker("", selection: $meeting.date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    Spacer()
                    PictureButton(imagePath: $meeting.background)
                    CameraButton(imagePath: $meeting.background)
                    Button(action: {
                        meeting.favorite.toggle()
                    }) {
                        if meeting.favorite {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        }
                    }
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.orange)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                Picker("", selection: $selectedTab) {
                    Text("Goals").tag(0)
                    Text("Rules").tag(1)
                    Text("Sessions").tag(2)
                    Text("Conclusion").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 8)

                TabView(selection: $selectedTab) {
                    TextNote(meeting: meeting, title: "Goals").tag(0)
                    TextNote(meeting: meeting, title: "Rules").tag(1)
                    SessionList(meeting: meeting, shouldStopTimer: $shouldStopTimer).tag(2)
                    TextNote(meeting: meeting, title: "Conclusion").tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack {
                    
                }
                
                Spacer()
            }
            .navigationTitle(meeting.topic)
            .alert("Are you sure you want to delete meeting \(meeting.topic)?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    context.delete(meeting)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .onDisappear(perform: ({
            shouldStopTimer = true
        }))
    }
}

