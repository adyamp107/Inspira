//
//  UserDefaults.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import Foundation

extension UserDefaults {
    private static let meetingKey = "anjayani"
    static func saveMeetings(_ meetings: [MeetingModel]) {
        if let encode = try? JSONEncoder().encode(meetings) {
            UserDefaults.standard.set(encode, forKey: meetingKey)
        }
    }
    static func loadMeetings() -> [MeetingModel] {
        if let data = UserDefaults.standard.data(forKey: meetingKey),
           let decoded = try? JSONDecoder().decode([MeetingModel].self, from: data) {
            return decoded
        }
        return []
    }
}
