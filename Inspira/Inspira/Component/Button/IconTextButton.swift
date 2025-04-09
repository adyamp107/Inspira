//
//  IconTextButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//
//
import SwiftUI
//
//struct IconTextButton: View {
//    let icon: String
//    let title: String
//    let selected: Bool
//    let action: () -> Void
//    var body: some View {
//        Button(
//            action: action,
//            label: {
//                HStack {
//                    Image(systemName: icon)
//                        .foregroundColor(selected ? .white : .blue)
//                        .font(.subheadline)
//                    Text(title)
//                        .foregroundColor(selected ? .white : .blue)
//                        .font(.subheadline)
//                }
//                .padding(.horizontal, 12)
//                .padding(.vertical, 8)
//                .background(selected ? Color.blue : Color.gray.opacity(0.2))
//                .cornerRadius(8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(selected ? Color.blue : Color.clear, lineWidth: 2)
//                )
//            }
//        )
//    }
//}

struct IconTextButton: View {
    let icon: String
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.subheadline)
                Text(title)
                    .font(.subheadline)
            }
            .foregroundColor(.blue)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(selected ? Color.blue.opacity(0.1) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .cornerRadius(8)
        }
    }
}


#Preview {
    @Previewable @State var isSelected: Bool = false
    IconTextButton(icon: "star", title: "Favorite", selected: isSelected) {
        isSelected.toggle()
    }
}
