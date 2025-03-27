//
//  MeetingPage.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI

struct MeetingPage: View {
    @Binding var meetings: [MeetingModel]
    let id: UUID

    @State private var selectedTab = 0
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var sessionIndex = -1
    
    @State var selectedImage: UIImage? = nil
    @State private var showAlert = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        let index = meetings.firstIndex(where: { $0.id == id }) ?? 0
        
        NavigationStack {
            VStack(spacing: 20) {
                VStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                .background(
                    Group {
                        let backgroundImage: String = meetings[index].background.isEmpty ?
                            ["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement()!
                            : meetings[index].background
                        if FileManager.default.fileExists(atPath: backgroundImage) {
                            Image(uiImage: UIImage(contentsOfFile: backgroundImage) ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .clipped()
                        } else if backgroundImage.contains("image") {
                            Image(backgroundImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .clipped()
                        } else if backgroundImage == "orange" {
                            Color.orange
                        } else {
                            Color.blue
                        }
                    }
                )
                HStack {
                    TextField("Enter topic", text: $meetings[index].topic)
                        .font(.title2)
                        .padding(.vertical, 5)
                        .background(Color.clear)
                    Spacer()
                }
                .padding(.horizontal)
                HStack(spacing: 20) {
                    DatePicker("", selection: $meetings[index].date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    Spacer()
                    PicturePicker(imagePath: $meetings[index].background)
                    CameraButton(imagePath: $meetings[index].background)
                    Button(action: {
                        meetings[index].favorite.toggle()
                    }) {
                        if meetings[index].favorite {
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
                Picker("", selection: $selectedTab) {
                    Text("Goals").tag(0)
                    Text("Rules").tag(1)
                    Text("Sessions").tag(2)
                    Text("Conclusion").tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                TabView(selection: $selectedTab) {
                    NoteView(meetings: $meetings, id: id, title: "Goals").tag(0)
                    NoteView(meetings: $meetings, id: id, title: "Rules").tag(1)
                    MeetingSessionsView(meetings: $meetings, id: id).tag(2)
                    NoteView(meetings: $meetings, id: id, title: "Conclusion").tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .edgesIgnoringSafeArea(.bottom)
            .alert("Are you sure you want to delete meeting \(meetings[index].topic)?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    meetings.remove(at: index)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
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
            goals: "Goals",
            rules: "Rules",
            conclusion: "Conclusion of meeting \(i)",
            favorite: Bool.random(),
            background: "image7",
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
    MeetingPage(meetings: $meetings, id: meetings[0].id)
}
