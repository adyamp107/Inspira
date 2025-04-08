//
//  DashboardView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]
    
    var filteredMeetings: [Meeting] {
        let now = Date()

        var filtered = meetings.filter { meeting in
            let matchesFavorite = !selectedFavorite || meeting.favorite
            let matchesPast = !selectedPast || meeting.date < now
            let matchesSearch = searchText.isEmpty ||
                meeting.topic.localizedCaseInsensitiveContains(searchText) ||
                meeting.date.formatted(.dateTime.day().month(.wide).year()).localizedCaseInsensitiveContains(searchText)
            
            return matchesFavorite && matchesPast && matchesSearch
        }
        
        if selectedUpcomingDate {
            filtered.sort { $0.date < $1.date }
        } else if selectedLatestDate {
            filtered.sort { $0.date > $1.date }
        }

        return filtered
    }
    
    @State private var selectedFavorite = false
    @State private var selectedUpcomingDate = false
    @State private var selectedLatestDate = false
    @State private var selectedPast = false
    
    @State private var searchText = ""
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width - 32
        let columnCount = max(Int(screenWidth / 150), 2)
        let itemWidth = (screenWidth / CGFloat(columnCount)) - (((CGFloat(columnCount) - 1) * 10) / CGFloat(columnCount))
        
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        IconTextButton(icon: "heart", title: "Favorite", selected: selectedFavorite) {
                            selectedFavorite.toggle()
                        }
                        IconTextButton(icon: "arrow.up", title: "Upcoming Date", selected: selectedUpcomingDate) {
                            selectedUpcomingDate.toggle()
                            if selectedLatestDate {
                                selectedLatestDate.toggle()
                            }
                        }
                        IconTextButton(icon: "arrow.down", title: "Latest Date", selected: selectedLatestDate) {
                            selectedLatestDate.toggle()
                            if selectedUpcomingDate {
                                selectedUpcomingDate.toggle()
                            }
                        }
                        IconTextButton(icon: "clock", title: "Past", selected: selectedPast) {
                            selectedPast.toggle()
                        }
                    }
                }
                .padding(.bottom, 8)
                if filteredMeetings.count > 0 {
                    ScrollView {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(0..<columnCount, id: \.self) { column in
                                VStack(spacing: 10) {
                                    ForEach(filteredMeetings.indices.filter { $0 % columnCount == column }, id: \.self) { index in
                                        CardButton(meeting: filteredMeetings[index], width: itemWidth)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                    VStack(spacing: 8) {
                        Text("No meeting! 😁")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("You can add new meeting! 👍")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                HStack {
                    NavigationLink(destination: AddMeetingView()) {
                        HStack {
                            Text("Add Meeting")
                        }
                        .foregroundColor(Color.white)
                        .frame(width: 200)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Welcome to Inspira")
            .onAppear(perform: {
                selectedFavorite = false
                selectedUpcomingDate = false
                selectedLatestDate = false
                selectedPast = false
            })
            .onDisappear(perform: {
                selectedFavorite = false
                selectedUpcomingDate = false
                selectedLatestDate = false
                selectedPast = false
            })
        }
        .navigationViewStyle(.stack)
        .searchable(text: $searchText, prompt: "Search Meetings and Date")
    }
}

#Preview {
    do {
        let previewContainer = try ModelContainer(
            for: Meeting.self, Session.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        return ContentView()
            .modelContainer(previewContainer)
    } catch {
        fatalError("Failed to create preview container: \(error)")
    }
}
