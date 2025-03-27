//
//  MeetingAddButton.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct TextButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(color)
            .cornerRadius(8)
        }
    }
}

#Preview {
    TextButton(title: "Test", color: .blue) {
    }
}
