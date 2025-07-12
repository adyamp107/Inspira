//
//  Data.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import Foundation
import SwiftData

@Model
class Meeting {
    var id: UUID = UUID()
    var order: Int
    var topic: String
    var date: Date
    var descriptions: String
    var conclusion: String
    var favorite: Bool
    var background: String
    var sessions: [Session]
    
    init(order: Int, topic: String, date: Date, descriptions: String, conclusion: String, favorite: Bool, background: String, sessions: [Session]) {
        self.order = order
        self.topic = topic
        self.date = date
        self.descriptions = descriptions
        self.conclusion = conclusion
        self.favorite = favorite
        self.background = background
        self.sessions = sessions
    }
}

@Model
class Session {
    var id: UUID = UUID()
    var order: Int
    var subTopic: String
    var name: String
    var duration: Double
    var notes: String
    var passedTime: Double
    
    init(order: Int, subTopic: String, name: String, duration: Double, notes: String, passedTime: Double
    ) {
        self.order = order
        self.subTopic = subTopic
        self.name = name
        self.duration = duration
        self.notes = notes
        self.passedTime = passedTime
    }
}
