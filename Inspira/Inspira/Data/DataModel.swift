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
    var rules: String
    var goals: String
    var conclusion: String
    var favorite: Bool
    var sessions: [SessionModel]
    var background: String
}

struct SessionModel: Codable, Equatable {
    var id: UUID = UUID()
    var subTopic: String
    var name: String
    var role: String
    var duration: TimeInterval
    var favorite: Bool
}
