//
//  MeetingCardButton.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 25/03/25.
//

import SwiftUI
import UIKit

struct MeetingCardButton: View {
    let meeting: MeetingModel
    let width: CGFloat
    let action1: () -> Void
    let action2: () -> Void
    var body: some View {
        Button(action: action1) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    Button(action: action2) {
                        Image(systemName: meeting.favorite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.red)
                    }
                    .simultaneousGesture(TapGesture().onEnded { })
                }
                .padding(.bottom, 100)
                Text(meeting.topic)
                    .font(.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                Text(meeting.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .frame(width: width)
            .background(
                Group {
                    if meeting.background.contains("image") {
                        ZStack {
                            Image(meeting.background)
                                .resizable()
                                .scaledToFill()
                                .frame(width: width)
                                .clipped()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        }
                    } else if meeting.background == "orange" {
                        Color.orange
                    } else if meeting.background == "blue" {
                        Color.blue
                    } else {
                        Color.blue
                    }
                }
//                Group {
//                    if Bool.random() {
//                        ZStack {
//                            Image(["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement() ?? "image1")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: width)
//                                .clipped()
//                            LinearGradient(
//                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
//                                startPoint: .bottom,
//                                endPoint: .top
//                            )
//                        }
//                    } else {
//                        Bool.random() ? Color.orange : Color.blue
//                    }
//                }
            )
            .cornerRadius(10)
        }
    }
}

#Preview {
    let randomSuffix = String((0..<Int.random(in: 20...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
    let screenWidth = UIScreen.main.bounds.width - 40
    let columnCount = max(Int(screenWidth / 150), 2)
    let buttonCardWidth = screenWidth / CGFloat(columnCount) - 10
    return MeetingCardButton(
        meeting: MeetingModel(
            topic: randomSuffix,
            date: Date(),
            rules: "Don't disturb!",
            goals: "Get Something",
            conclusion: "Just do it!",
            favorite: true,
            sessions: [],
            background: "image2"
        ),
        width: buttonCardWidth,
        action1: {
            
        },
        action2: {
            
        }
    )
}
