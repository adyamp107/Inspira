//
//  SessionList.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//

import SwiftUI
import SwiftData

struct SessionList: View {
    @Bindable var meeting: Meeting
    @Binding var shouldStopTimer: Bool
    
    @State private var playingSession: Session?
    @State private var expandSession: Session?
    @State private var timer: Timer?
    @State private var selectedSession: Session?
    @State private var isNavigatingToAddSession = false
    @State private var noteSession: Session?
    @State private var deleteSession: Session?

    @State private var timerTask: Task<Void, Never>?
    
    @Environment(\.modelContext) private var modelContext
        
    var body: some View {
        VStack {
            if meeting.sessions.count > 0 {
                ScrollView {
                    ForEach(meeting.sessions.sorted(by: { $0.order > $1.order }), id: \.order) { session in
                        Button(
                            action: {
                                withAnimation {
                                    expandSession = (expandSession == session) ? nil : session
                                }
                            },
                            label: {
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(session.subTopic.isEmpty ? "No Data" : session.subTopic)
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                            Text("Duration: \(formatTime(session.duration))")
                                                .font(.subheadline)
                                            Text("Passed Time: \(formatTime(session.passedTime))")
                                                .font(.subheadline)
                                        }
                                        Spacer()
                                        HStack {
                                            Button(action: {
                                                session.passedTime = 0
                                            }) {
                                                Image(systemName: "gobackward")
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                    .background(Circle().fill(Color.accentColor))
                                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                                            }
                                            Button(action: { togglePlay(session) }) {
                                                Image(systemName: (session.passedTime < session.duration && playingSession == session && !shouldStopTimer) ? "pause.fill" : "play.fill")
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                    .background(Circle().fill(Color.accentColor))
                                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                                            }
                                            Image(systemName: "chevron.down")
                                                .rotationEffect(.degrees(expandSession == session ? 180 : 0))
                                                .foregroundColor(.gray)
                                                .padding(.leading, 5)
                                                .animation(.easeInOut(duration: 0.5), value: expandSession == session)
                                        }
                                    }
                                    ProgressView(
                                        value: Double(session.passedTime),
                                        total: Double(session.duration)
                                    )
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .frame(height: 6)
                                    .accentColor(.blue)
                                }
                            }
                        )
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        if expandSession == session {
                            VStack(spacing: 5) {
                                HStack {
                                    Text("Person in Charge:")
                                        .frame(width: 200, alignment: .leading)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(session.name.isEmpty ? "No Data" : session.name)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                HStack {
                                    Text("Role:")
                                        .frame(width: 200, alignment: .leading)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(session.role.isEmpty ? "No Data" : session.role)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                HStack(spacing: 50) {
                                    Button(
                                        action: {
                                            noteSession = session
                                        },
                                        label: {
                                            Image(systemName: "note")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.orange)
                                        }
                                    )
                                    Button(action: {
                                        stopTimer()
                                        selectedSession = session
                                    }) {
                                        Image(systemName: "pencil")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.blue)
                                    }
                                    Button(
                                        action: {
                                            deleteSession = session
                                        },
                                        label: {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.red)
                                        }
                                    )
                                }
                                .padding(.top, 5)
                            }
                            .frame(height: expandSession == session ? nil : 0)
                            .animation(.easeInOut(duration: 10), value: expandSession)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            } else {
                Spacer()
                VStack(spacing: 8) {
                    Text("No sessions! 😁")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("You can add new sessions! 👍")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            VStack {
                Button(action: {
                    stopTimer()
                    isNavigatingToAddSession = true
                }) {
                    Text("Add Session")
                }
                .padding(.vertical, 8)
            }
        }
        .navigationDestination(isPresented: $isNavigatingToAddSession) {
             AddSessionView(meeting: meeting)
         }
        .navigationDestination(item: $selectedSession) { session in
            EditSessionView(session: session)
        }
        .sheet(item: $noteSession) { session in
            VStack {
                Text(session.subTopic.isEmpty ? "No Data" : session.subTopic)
                    .padding(.top)
                TextEditor(text: Binding(
                    get: {
                        session.notes
                    },
                    set: { newValue in
                        session.notes = newValue
                    }
                ))
                .frame(maxHeight: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .padding()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .onDisappear(perform: {
                noteSession = nil
            })
        }
        .alert(item: $deleteSession) { session in
            Alert(
                title: Text("Delete Session"),
                message: Text("Are you sure you want to delete session '\(session.subTopic)'?"),
                primaryButton: .destructive(Text("Delete")) {
                    meeting.sessions.removeAll { $0.id == session.id }
                    deleteSession = nil
                },
                secondaryButton: .cancel {
                    deleteSession = nil
                }
            )
        }
        .onAppear(perform: {
            shouldStopTimer = false
        })
    }
    
    private func togglePlay(_ session: Session) {
        if playingSession == session {
            stopTimer()
        } else {
            stopTimer()
            playingSession = session
            startTimer(for: session)
        }
    }

    private func startTimer(for session: Session) {
        timerTask = Task {
            while session.passedTime < session.duration && playingSession == session && !shouldStopTimer {
                try? await Task.sleep(nanoseconds: 100_000_000)
                session.passedTime += 0.1
                if session.passedTime >= session.duration {
                    stopTimer()
                }
            }
            if session.passedTime >= session.duration {
                stopTimer()
            }
        }
    }

    public func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
        playingSession = nil
    }

    private func formatTime(_ time: Double) -> String {
        let totalSeconds = Int(time)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
