//
//  ContentView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI

struct HomePage: View {
    @State private var searchText: String = ""
    @State private var selectedFavorite = false
    @State private var selectedSort = "default"
    @State private var selectedPast = false
    @State private var addMeetingSheet = false
    
    @State private var selectedMeetingID: UUID?
    
    // initiate data
    @State private var meetings: [MeetingModel] = (1...50).map { i in
        let randomSuffix = String((0..<Int.random(in: 10...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
        return MeetingModel(
            topic: "Meeting \(i) \(randomSuffix)",
            date: Date().addingTimeInterval(Double(i) * 86400),
            rules: "Rules",
            goals: "Goals",
            conclusion: "Conclusion of meeting \(i)",
            favorite: Bool.random(),
            sessions: [],
            background: Bool.random() ? Bool.random() ? "orange" : "blue" : ["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement() ?? "image1"
        )
    }
    
    var filteredMeetings: [MeetingModel] {
        let now = Date()
        let reversedMeetings = meetings.reversed()
        let filtered = reversedMeetings.filter { meeting in
            (!selectedFavorite || meeting.favorite) &&
            (searchText.isEmpty ||
             meeting.topic.localizedCaseInsensitiveContains(searchText) ||
             meeting.date.formatted(.dateTime.day().month(.wide).year()).localizedCaseInsensitiveContains(searchText))
        }
        switch selectedSort {
        case "upcoming":
            return filtered
                .filter { $0.date >= now }
                .sorted { $0.date < $1.date }
        case "latest":
            return filtered
                .filter { $0.date >= now }
                .sorted { $0.date > $1.date }
        case "past":
            return filtered
                .filter { $0.date < now }
                .sorted { $0.date > $1.date }
        default:
            return filtered
        }
    }
    
    func handleDataChange() {
        print("Meetings or Sessions have changed.")
    }
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width - 40
        let columnCount = max(Int(screenWidth / 150), 2)
        let itemWidth = screenWidth / CGFloat(columnCount) - 10
        
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            MeetingFilterButton(icon: "star", title: "Favorite", selected: selectedFavorite) {
                                selectedFavorite = selectedFavorite ? false : true
                            }
                            MeetingFilterButton(icon: "arrow.up", title: "Upcoming", selected: selectedSort == "upcoming" ? true : false) {
                                selectedSort = selectedSort == "upcoming" ? "default" : "upcoming"
                            }
                            MeetingFilterButton(icon: "arrow.down", title: "Latest", selected: selectedSort == "latest" ? true : false) {
                                selectedSort = selectedSort == "latest" ? "default" : "latest"
                            }
                            MeetingFilterButton(icon: "clock", title: "Past", selected: selectedPast) {
                                selectedPast = selectedPast ? false : true
                            }
                        }
                        .frame(height: 50)
                    }
                    ScrollView {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(0..<columnCount, id: \.self) { column in
                                VStack(spacing: 10) {
                                    ForEach(filteredMeetings.indices.filter { $0 % columnCount == column }, id: \.self) { index in
                                        let meeting = filteredMeetings[index]
                                        
                                        MeetingCardButton(
                                            meeting: meeting,
                                            width: itemWidth,
                                            action1: {
                                                selectedMeetingID = meeting.id
                                            },
                                            action2: {
                                                if let foundIndex = meetings.firstIndex(where: { $0.id == meeting.id }) {
                                                    meetings[foundIndex].favorite.toggle()
                                                }
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(item: $selectedMeetingID) { id in
                        MeetingPage(meetings: $meetings, id: id)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Welcome to MeetGe")
                .searchable(text: $searchText)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        AddMeetingButton() {
                            addMeetingSheet = true
                        }
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $addMeetingSheet) {
                AddMeetingSheet(meetings: $meetings)
            }
            .onChange(of: meetings) { previous, current in
                handleDataChange()
            }
        }
    }
}

#Preview {
    HomePage()
}
