//
//  MeetingAddButton.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct AddMeetingButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
                .padding(10)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding()
    }
}

#Preview {
    AddMeetingButton() {
        
    }
}
