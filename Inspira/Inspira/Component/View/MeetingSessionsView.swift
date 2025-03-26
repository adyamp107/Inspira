//
//  MeetingSessionsView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct MeetingSessionsView: View {
    @State private var isExpanded = false
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Sessions").bold()) {
                    DisclosureGroup("Session Details", isExpanded: $isExpanded) {
                        Text("Session 1: Introduction")
                        Text("Session 2: Discussion")
                        Text("Session 3: Closing Remarks")
                    }
                }
            }
            HStack {
                
            }
        }
    }
}

#Preview {
    MeetingSessionsView()
}
