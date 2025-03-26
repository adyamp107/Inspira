//
//  MeetingRulesView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct MeetingRulesView: View {
    @State private var rulesText: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Rules").bold()) {
                TextEditor(text: $rulesText)
                    .frame(minHeight: 400)
                    .cornerRadius(8)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    MeetingRulesView()
}
