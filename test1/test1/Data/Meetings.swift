//
//  Meetings.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 27/03/25.
//

import Foundation

class Meetings: ObservableObject {
    @Published var meetings: [MeetingModel] = []
    
    init() {
        loadMeetings()
    }
    
    func loadMeetings() {
        guard meetings.isEmpty else { return }
        
        meetings.append(MeetingModel(
            topic: "No Data",
            date: Date(),
            goals: "No Data",
            rules: "No Data",
            conclusion: "No Data",
            favorite: false,
            background: "blue",
            sessions: generateRandomSessions()
        ))
        
        meetings.append(contentsOf: (1...50).map { i in
            let randomSuffix = String((0..<Int.random(in: 10...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
            return MeetingModel(
                topic: "Meeting \(i) \(randomSuffix)",
                date: Date().addingTimeInterval(Double(i) * 86400),
                goals: "Goals",
                rules: "Rules",
                conclusion: "Conclusion of meeting \(i)",
                favorite: Bool.random(),
                background: Bool.random() ? Bool.random() ? "orange" : "blue" : ["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement() ?? "image1",
                sessions: generateRandomSessions()
            )
        })
    }
    
    private func generateRandomSessions() -> [SessionModel] {
        let roles = ["Moderator", "Speaker", "Attendee", "Time Keeper", "Note Taker"]
        let topics = ["Project Update", "Strategy Discussion", "Tech Review", "Budget Planning", "Team Building"]
        let names = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank"]
        
        let sessionCount = Int.random(in: 1...5)
        
        return (0..<sessionCount).map { _ in
            SessionModel(
                subTopic: topics.randomElement() ?? "No Data",
                name: names.randomElement() ?? "No Data",
                role: roles.randomElement() ?? "No Data",
                duration: TimeInterval(Int.random(in: 300...3600)),
                notes: "Random notes for the session",
                timeLeft: TimeInterval(Int.random(in: 300...3600))
            )
        }
    }
}
