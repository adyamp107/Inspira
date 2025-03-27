//
//  MeetingSessionsView.swift
//  MeetGe
//
//  Created by Adya Muhammad Prawira on 26/03/25.
//

import SwiftUI

struct MeetingSessionsView: View {
    @Binding var meetings: [MeetingModel]
    let id: UUID
    
    @State private var addSessionSheet = false
    
    @State private var sessionIndexExpanded = 0
    @State private var sessionIndexPlay = 0
    
    var body: some View {
        let index = meetings.firstIndex(where: { $0.id == id }) ?? 0
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(meetings[index].sessions.indices.reversed(), id: \.self) { sessionIndex in
                        ListButton(
                            session: $meetings[index].sessions[sessionIndex],
                            onDelete: {
                                // Aksi hapus di sini
                            }
//                            isExpanded: Binding(
//                
//                            )
                        )
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
            .scrollContentBackground(.hidden)
            HStack {
                TextButton(title: "Add Session", color: Color.blue, action: {
                    addSessionSheet = true
                })
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .sheet(isPresented: $addSessionSheet) {
            AddSessionSheet(meeting: $meetings[index])
        }
    }
}

//struct MeetingSessionsView: View {
//    @Binding var meetings: [MeetingModel]
//
//    let id: UUID
//    @State private var isExpanded = false
//    @State private var searchText: String = ""
//    
//    let action: () -> Void
//
//    var body: some View {
//        
//        let index = meetings.firstIndex(where: { $0.id == id }) ?? 0
//        
//        VStack {
//            ScrollView {
//                VStack(spacing: 0) {
//                    ForEach(meetings[index].sessions.indices, id: \.self) { index in
////                        ListButton(
////                            title: sessions[index].0,
////                            responsiblePerson: sessions[index].1,
////                            role: sessions[index].2,
////                            onDelete: {
////                                sessions.remove(at: index)
////                            }
////                        )
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .background(Color(UIColor.systemGroupedBackground))
//            .scrollContentBackground(.hidden)
//            
//            HStack(spacing: 10) {
//                TextButton(title: "Add Session", color: .blue, action: action)
//            }
//            .padding(.horizontal)
//        }
//        .background(Color(.systemGroupedBackground)
//        .ignoresSafeArea())
//    }
//}

#Preview {
//    @Previewable @State var meetings: [MeetingModel] = (1...50).map { i in
//        let randomSuffix = String((0..<Int.random(in: 10...50)).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
//        return MeetingModel(
//            topic: "Meeting \(i) \(randomSuffix)",
//            date: Date().addingTimeInterval(Double(i) * 86400),
//            goals: "Goals",
//            rules: "Rules",
//            conclusion: "Conclusion of meeting \(i)",
//            favorite: Bool.random(),
//            background: "image7",
//            sessions: [
//                SessionModel(
//                    subTopic: "No Data",
//                    name: "No Data",
//                    role: "No Data",
//                    duration: 60,
//                    notes: "No Data",
//                    timeLeft: 60
//                )
//            ]
//        )
//    }
//    MeetingSessionsView(meetings: $meetings, id: meetings[0].id, action: {})
    HomePage()
}
