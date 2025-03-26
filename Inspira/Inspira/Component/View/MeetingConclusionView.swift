//
//  MeetingConclusionView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct MeetingConclusionView: View {
    @State private var conclusionText: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Conclusion").bold()) {
                TextEditor(text: $conclusionText)
                    .frame(minHeight: 400)
                    .cornerRadius(8)
                    .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    MeetingConclusionView()
}
