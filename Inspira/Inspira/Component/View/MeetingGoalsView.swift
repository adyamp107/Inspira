//
//  MeetingGoalsView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct MeetingGoalsView: View {
    @State private var goalsText: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Goals").bold()) {
                TextEditor(text: $goalsText)
                    .frame(minHeight: 400)
                    .cornerRadius(8)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    MeetingGoalsView()
}
