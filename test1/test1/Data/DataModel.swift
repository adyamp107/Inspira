//
//  DataModel.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import Foundation
import UIKit

struct MeetingModel: Codable, Equatable {
    var id: UUID = UUID()
    var topic: String
    var date: Date
    var goals: String
    var rules: String
    var conclusion: String
    var favorite: Bool
    var background: String
    var sessions: [SessionModel]
}

struct SessionModel: Codable, Equatable {
    var id: UUID = UUID()
    var subTopic: String
    var name: String
    var role: String
    var duration: TimeInterval
    var notes: String
    var timeLeft: TimeInterval
}
