//
//  DropdownFilterButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 09/04/25.
//


import SwiftUI

struct DropdownFilterButton: View {
    let icon: String
    let title: String
    let options: [String]
    let defaultOption: String
    @Binding var selectedOption: String?

    var isSelected: Bool {
        selectedOption != nil && selectedOption != defaultOption
    }

    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    Label(option, systemImage: selectedOption == option ? "checkmark" : "")
                }
            }
        } label: {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text("\(title)\(selectedOption != nil ? ": \(selectedOption!)" : "")")
                Image(systemName: "chevron.down")
            }
            .font(.subheadline)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
            )
            .cornerRadius(8)
        }
    }
}
