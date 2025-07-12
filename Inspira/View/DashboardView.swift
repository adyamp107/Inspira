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

    @State private var lastScheduledMeetingIDs: Set<UUID> = []
        
    @State private var selectedFavorite = false
    @State private var selectedDateFilter: String? = "All"
    @State private var selectedProgress: String? = "All"
    @State private var selectedSortDate: String? = "None"

    @State private var searchText = ""
    
    @State private var showAlert = false
    @State private var actionToConfirm: (() -> Void)?
    @State private var confirmationMessage = ""
    @State private var confirmationMessageTitle = ""
    
    var filteredMeetings: [Meeting] {
        let now = Date()
        let calendar = Calendar.current

        var filtered = meetings

        // FILTER: Favorite
        if selectedFavorite {
            filtered = filtered.filter { $0.favorite }
        }

        // FILTER: Progress
        if let progress = selectedProgress {
            switch progress {
            case "Draft":
                filtered = filtered.filter { $0.topic.isEmpty || $0.sessions.count == 0 }
            case "Scheduled":
                filtered = filtered.filter { !$0.topic.isEmpty && $0.sessions.count > 0 && totalPassedTime(for: $0) == 0 && totalDuration(for: $0) > 0 && $0.date >= now }
            case "Completed":
                filtered = filtered.filter { !$0.topic.isEmpty && $0.sessions.count > 0 && totalPassedTime(for: $0) > 0 && totalDuration(for: $0) > 0 && $0.date <= now }
            case "Cancelled":
                filtered = filtered.filter { !$0.topic.isEmpty && $0.sessions.count > 0 && totalPassedTime(for: $0) == 0 && $0.date < now }
            default:
                break
            }
        }

        // FILTER: Date
        if let dateFilter = selectedDateFilter {
            switch dateFilter {
            case "Today":
                filtered = filtered.filter { calendar.isDate($0.date, inSameDayAs: now) }
            case "This Week":
                if let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) {
                    let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
                    filtered = filtered.filter { $0.date >= startOfWeek && $0.date <= endOfWeek }
                }

            case "This Month":
                let components = calendar.dateComponents([.year, .month], from: now)
                if let startOfMonth = calendar.date(from: components),
                   let range = calendar.range(of: .day, in: .month, for: now) {
                    let endOfMonth = calendar.date(byAdding: .day, value: range.count - 1, to: startOfMonth)!
                    filtered = filtered.filter { $0.date >= startOfMonth && $0.date <= endOfMonth }
                }
            case "Upcoming":
                filtered = filtered.filter { $0.date > now }
            case "Past":
                filtered = filtered.filter { $0.date < now }
            default:
                break
            }
        }

        // FILTER: Search
        filtered = filtered.filter { meeting in
            searchText.isEmpty ||
            meeting.topic.localizedCaseInsensitiveContains(searchText) ||
            meeting.date.formatted(.dateTime.day().month(.wide).year()).localizedCaseInsensitiveContains(searchText)
        }

        // SORT
        switch selectedSortDate {
        case "Ascending":
            filtered.sort { $0.date < $1.date }
        case "Descending":
            filtered.sort { $0.date > $1.date }
        default:
            filtered.sort { $0.order > $1.order }
        }

        return filtered
    }
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width - 32
        let columnCount = max(Int(screenWidth / 150), 2)
        let itemWidth = (screenWidth / CGFloat(columnCount)) - (((CGFloat(columnCount) - 1) * 10) / CGFloat(columnCount))

        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        IconTextButton(
                            icon: "heart",
                            title: "Favorite",
                            selected: selectedFavorite
                        ) {
                            selectedFavorite.toggle()
                        }

                        DropdownFilterButton(
                            icon: "arrow.up.arrow.down",
                            title: "Sort by Date",
                            options: ["None", "Ascending", "Descending"],
                            defaultOption: "None",
                            selectedOption: $selectedSortDate
                        )

                        DropdownFilterButton(
                            icon: "calendar",
                            title: "Date Filter",
                            options: ["All", "Today", "This Week", "This Month", "Upcoming", "Past"],
                            defaultOption: "All",
                            selectedOption: $selectedDateFilter
                        )

                        DropdownFilterButton(
                            icon: "clock",
                            title: "Progress",
                            options: ["All", "Draft", "Scheduled", "Completed", "Cancelled"],
                            defaultOption: "All",
                            selectedOption: $selectedProgress
                        )
                        
                        Button("Reset") {
                            selectedFavorite = false
                            selectedSortDate = "None"
                            selectedDateFilter = "All"
                            selectedProgress = "All"
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        
                    }
                    .padding(.bottom, 8)
                }


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
            .navigationBarTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            confirmationMessage = "Are you sure you want to delete all filtered meetings?"
                            confirmationMessageTitle = "Delete All"
                            actionToConfirm = {
                                for meeting in filteredMeetings {
                                    context.delete(meeting)
                                }
                                try? context.save()
                            }
                            showAlert = true
                        } label: {
                            Label("Delete All", systemImage: "trash")
                        }

                        Button {
                            confirmationMessage = "Mark all filtered meetings as favorite?"
                            confirmationMessageTitle = "Favorite All"
                            actionToConfirm = {
                                for meeting in filteredMeetings {
                                    meeting.favorite = true
                                }
                                try? context.save()
                            }
                            showAlert = true
                        } label: {
                            Label("Favorite All", systemImage: "heart.fill")
                        }

                        Button {
                            confirmationMessage = "Unmark all filtered meetings as favorite?"
                            confirmationMessageTitle = "Unfavorite All"
                            actionToConfirm = {
                                for meeting in filteredMeetings {
                                    meeting.favorite = false
                                }
                                try? context.save()
                            }
                            showAlert = true
                        } label: {
                            Label("Unfavorite All", systemImage: "heart")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(confirmationMessageTitle),
                    message: Text(confirmationMessage),
                    primaryButton: .destructive(Text("Yes")) {
                        actionToConfirm?()
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                selectedFavorite = false
                selectedDateFilter = "All"
                selectedProgress = "All"
                selectedSortDate = "None"

                requestNotificationPermission()
                scheduleUpcomingMeetingNotifications()
            }
            .onDisappear {
                selectedFavorite = false
                selectedDateFilter = "All"
                selectedProgress = "All"
                selectedSortDate = "None"

            }
        }
        .navigationViewStyle(.stack)
        .searchable(text: $searchText, prompt: "Search Meetings and Date")
        .onChange(of: meetings) {
            scheduleUpcomingMeetingNotifications()
        }
    }

    private func scheduleUpcomingMeetingNotifications() {
        let calendar = Calendar.current
        let today = Date()
        let todayMeetings = meetings.filter {
            calendar.isDate($0.date, equalTo: today, toGranularity: .day)
        }

        for meeting in todayMeetings {
            if !lastScheduledMeetingIDs.contains(meeting.id) {
                print("📆 Scheduling today notification for: \(meeting.topic)")
                scheduleNotification(for: meeting)
            }
        }

        lastScheduledMeetingIDs = Set(todayMeetings.map { $0.id })
    }
    
    private func totalPassedTime(for meeting: Meeting) -> Double {
        meeting.sessions.reduce(0) { $0 + $1.passedTime }
    }

    private func totalDuration(for meeting: Meeting) -> Double {
        meeting.sessions.reduce(0) { $0 + $1.duration }
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

