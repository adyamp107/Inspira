//
//  ListButton.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 27/03/25.
//

import SwiftUI

struct ListButton: View {
    @Binding var session: SessionModel

    var onDelete: () -> Void

    @State private var isPlaying = false
    @State private var progress: CGFloat = 0.0
    @State private var isExpanded = false
    @State private var timer: Timer?

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(session.subTopic)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(isPlaying ? "Playing..." : "Paused")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(formatTime(session.duration - session.timeLeft))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .monospacedDigit()
                        .padding(.trailing, 8)
                    Button(action: {
                        togglePlay()
                    }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Circle().fill(Color.accentColor))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                    }
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .foregroundColor(.gray)
                        .padding(.leading, 5)
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                }
                .padding()
                .background(
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 0)
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: progress * geometry.size.width)
                            .animation(.linear(duration: 0.2), value: progress)
                        }
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 0))
                .contentShape(Rectangle())
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                    HStack {
                        Text("Person in Charge:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(session.name)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Role:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(session.role)
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Duration:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(formatTime(session.duration))
                            .font(.caption)
                            .foregroundColor(.primary)
                    }
                    
                    HStack(spacing: 50) {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        }
                        Button(action: {}) {
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.blue)
                        }
                        Button(action: {}) {
                            Image(systemName: "note")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.blue)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .padding()
                .transition(.opacity)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color(UIColor.systemBackground))
        )
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }

    private func togglePlay() {
        isPlaying.toggle()
        if isPlaying {
            startProgress()
        } else {
            stopProgress()
        }
    }

    private func startProgress() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if progress < 1.0 {
                progress += 0.01
            } else {
                stopProgress()
            }
        }
    }
    
//    private func startProgress() {
//        timer?.invalidate()
//        
//        let totalTime = session.duration
//        let remainingTime = session.timeLeft
//        let step = 1.0 / totalTime  // Langkah progres per detik
//        
//        withAnimation(.linear(duration: remainingTime)) {
//            progress = 1.0  // Progress menuju penuh sesuai timeLeft
//        }
//
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if session.timeLeft > 0 {
//                session.timeLeft -= 1  // Update sisa waktu
//            } else {
//                stopProgress()
//            }
//        }
//    }


    private func stopProgress() {
        timer?.invalidate()
        isPlaying = false
    }

//    private func stopProgress() {
//        timer?.invalidate()
//        isPlaying = false
//        withAnimation { progress = CGFloat(session.timeLeft) / CGFloat(session.duration) }
//    }

    
    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
//    VStack(spacing: 0) {
//        ListButton(
//            title: "Session 1",
//            responsiblePerson: "Anjay",
//            role: "Dunno",
//            onDelete: {}
//        )
//        ListButton(
//            title: "Session 1",
//            responsiblePerson: "Anjay",
//            role: "Dunno",
//            onDelete: {}
//        )
//    }
    HomePage()
}
