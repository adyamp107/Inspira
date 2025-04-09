//
//  CardButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import SwiftData

struct CardButton: View {
    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]

    var meeting: Meeting
    let width: CGFloat

    var body: some View {
        NavigationLink(destination: MeetingView(meeting: meeting)) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Spacer()
                    Button(
                        action: {
                            meeting.favorite.toggle()
                        },
                        label: {
                            Image(systemName: meeting.favorite ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                    )
                    .buttonStyle(.plain)
                }
                .padding(.bottom, 100)

                Text(
                    meeting.topic.isEmpty ? "Untitled" : meeting.topic
                )
                    .fontWeight(.bold)
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
                        ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "orange", "blue"].randomElement()!
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
    CardButton(
        meeting: Meeting(
            order: 1,
            topic: "Sprint Planning Meeting 2025 (Very Important)",
            date: Date(),
            descriptions: "Plan next sprint",
            conclusion: "Next steps defined",
            favorite: true,
            background: "image2",
            sessions: []
        ),
        width: 200
    )
}
