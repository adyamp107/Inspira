//
//  MeetingPage.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI

struct MeetingPage: View {
    @Binding var meetings: [MeetingModel]
    @State var id: UUID

    @State private var selectedTab = 0
    @State private var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State private var title: String = "Meeting"
    
    var meetingIndex: Int? {
        meetings.firstIndex { $0.id == id }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if let index = meetingIndex {
                    HStack {
                        Text(meetings[index].topic)
                            .font(.title2)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    HStack(spacing: 20) {
                        DatePicker("", selection: $meetings[index].date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.blue)
                        }
                        
                        Button(action: {}) {
                            if meetings[index].favorite {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.red)
                            } else {
                                Image(systemName: "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                } else {
                    
                }
                Picker("", selection: $selectedTab) {
                    Text("Rules").tag(0)
                    Text("Goals").tag(1)
                    Text("Sessions").tag(2)
                    Text("Conclusion").tag(3)
                }
                .pickerStyle(.segmented)
                .padding()

                TabView(selection: $selectedTab) {
                    MeetingRulesView().tag(0)
                    MeetingGoalsView().tag(1)
                    MeetingSessionsView().tag(2)
                    MeetingConclusionView().tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .navigationTitle("Let's Get Started!")

//            .navigationTitle(meetingIndex != nil ? meetings[meetingIndex!].topic : meetingDefault.topic)
            .edgesIgnoringSafeArea(.bottom)
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
    return MeetingPage(meetings: $meetings, id: meetings[0].id)
}
