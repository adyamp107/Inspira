//
//  IconTextButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI

struct IconTextButton: View {
    let icon: String
    let title: String
    let selected: Bool
    let action: () -> Void
    var body: some View {
        Button(
            action: action,
            label: {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(selected ? .white : .blue)
                    Text(title)
                        .fontWeight(.medium)
                        .foregroundColor(selected ? .white : .blue)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selected ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(selected ? Color.blue : Color.clear, lineWidth: 2)
                )
            }
        )
    }
}

#Preview {
    IconTextButton(icon: "star", title: "Favorite", selected: false) {
        
    }
    IconTextButton(icon: "star", title: "Favorite", selected: true) {
        
    }
}
