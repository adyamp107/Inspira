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
    @State private var showSheet = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            ZStack {
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
                        Spacer()
                        Button(action: {
                            showSheet = true
                        }) {
                            VStack {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .padding(10)
                            }
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.65))
                            .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: 200)
            }
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
                    Text("Descriptions").tag(0)
                    Text("Sessions").tag(1)
                    Text("Conclusion").tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 8)

                TabView(selection: $selectedTab) {
                    TextNote(meeting: meeting, title: "Descriptions").tag(0)
                    SessionList(meeting: meeting, shouldStopTimer: $shouldStopTimer).tag(1)
                    TextNote(meeting: meeting, title: "Conclusion").tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack {
                    
                }
                
                Spacer()
            }
            .navigationTitle(
                meeting.topic.isEmpty ? "Untitled" : meeting.topic
            )
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Meeting"),
                    message: Text("Are you sure you want to delete meeting \(meeting.topic.isEmpty ? "Untitled" : meeting.topic)?"),
                    primaryButton: .destructive(Text("Delete")) {
                        context.delete(meeting)
                        dismiss()
                    },
                    secondaryButton: .cancel {
                    }
                )
            }
            .sheet(isPresented: $showSheet) {
                VStack() {
                    Spacer()
                    HStack {
                        PictureTextButton(imagePath: $meeting.background)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        CameraTextButton(imagePath: $meeting.background)
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.visible)
            }
        }
        .onDisappear(perform: ({
            shouldStopTimer = true
        }))
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

