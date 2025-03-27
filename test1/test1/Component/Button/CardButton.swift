//
//  CardButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct CardButton: View {
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
                    let backgroundImage: String = meeting.background.isEmpty ?
                        ["image1", "image2", "image3", "image4", "image5", "image6", "image7"].randomElement()!
                        : meeting.background
                    if FileManager.default.fileExists(atPath: backgroundImage) {
                        ZStack {
                            Image(uiImage: UIImage(contentsOfFile: backgroundImage) ?? UIImage())
                                .resizable()
                                .scaledToFill()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        }
                    } else if
                        backgroundImage.contains("image") {
                        ZStack {
                            Image(backgroundImage)
                                .resizable()
                                .scaledToFill()
                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        }
                    } else if backgroundImage == "orange" {
                        Color.orange
                    } else {
                        Color.blue
                    }
                }
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
    CardButton(
        meeting: MeetingModel(
            topic: randomSuffix,
            date: Date(),
            goals: "Get Something",
            rules: "Don't disturb!",
            conclusion: "Just do it!",
            favorite: true,
            background: "image2",
            sessions: []
        ),
        width: buttonCardWidth,
        action1: {
            
        },
        action2: {
            
        }
    )
}
