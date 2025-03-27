//
//  ContentView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI

struct HomePage: View {
    @State private var meetings: [MeetingModel] = Meetings().meetings

    @State private var searchText: String = ""
    @State private var selectedFavorite = false
    @State private var selectedSort = "default"
    @State private var selectedPast = false
    @State private var addMeetingSheet = false
    
    @State private var selectedMeetingID: UUID?
    
    var filteredMeetings: [MeetingModel] {
        let now = Date()
        let reversedMeetings = Array(meetings.dropFirst()).reversed()
        let filtered = reversedMeetings.filter { meeting in
            let matchesFavorite = !selectedFavorite || meeting.favorite
            let matchesSearch = searchText.isEmpty ||
                meeting.topic.localizedCaseInsensitiveContains(searchText) ||
                meeting.date.formatted(.dateTime.day().month(.wide).year()).localizedCaseInsensitiveContains(searchText)
            
            return matchesFavorite && matchesSearch
        }
        let sortedMeetings: [MeetingModel]
        switch selectedSort {
        case "upcoming":
            sortedMeetings = filtered
                .filter { $0.date >= now }
                .sorted { $0.date < $1.date }
        case "latest":
            sortedMeetings = filtered
                .filter { $0.date >= now }
                .sorted { $0.date > $1.date }
        case "past":
            sortedMeetings = filtered
                .filter { $0.date < now }
                .sorted { $0.date > $1.date }
        default:
            sortedMeetings = filtered
        }
        return sortedMeetings
    }

    
    func handleDataChange() {
        print("Meetings or Sessions have changed.")
    }
    
    var body: some View {
        
        let screenWidth = UIScreen.main.bounds.width - 40
        let columnCount = max(Int(screenWidth / 150), 2)
        let itemWidth = screenWidth / CGFloat(columnCount) - 10
        
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        IconTextButton(icon: "star", title: "Favorite", selected: selectedFavorite) {
                            selectedFavorite = selectedFavorite ? false : true
                        }
                        IconTextButton(icon: "arrow.up", title: "Upcoming", selected: selectedSort == "upcoming" ? true : false) {
                            selectedSort = selectedSort == "upcoming" ? "default" : "upcoming"
                        }
                        IconTextButton(icon: "arrow.down", title: "Latest", selected: selectedSort == "latest" ? true : false) {
                            selectedSort = selectedSort == "latest" ? "default" : "latest"
                        }
                        IconTextButton(icon: "clock", title: "Past", selected: selectedPast) {
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
                                    CardButton(
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
                HStack {
                    TextButton(title: "Add Meeting", color: .blue) {
                        addMeetingSheet = true
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Welcome to Inspira")
            .searchable(text: $searchText)
            .sheet(isPresented: $addMeetingSheet) {
                AddMeetingSheet(meetings: $meetings)
            }
            .onChange(of: meetings) {
                Task {
                    handleDataChange()
                }
            }
        }
    }
}

#Preview {
    HomePage()
}
