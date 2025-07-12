////
////  AddMeetingView.swift
////  Inspira
////
////  Created by Adya Muhammad Prawira on 06/04/25.
////
//
//import SwiftUI
//import SwiftData
//
//struct AddMeetingView: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]
//
//    @State private var order: Int = 0
//    @State private var topic: String = ""
//    @State private var date: Date = Date()
//    @State private var descriptions: String = ""
//    @State private var conclusion: String = ""
//    @State private var favorite: Bool = false
//    @State private var background: String = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "orange", "blue"].randomElement()!
//    @State private var sessions: [Session] = []
//    
//    @State private var isEditingGoals = false
//    
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 40) {
//                VStack(spacing: 15) {
//                    Text("Add Meeting")
//                        .font(.title2.bold())
//                    VStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Meeting Topic")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            TextField("Enter topic", text: $topic)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                )
//                                .autocorrectionDisabled()
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                    }
//                    VStack {
//                        HStack(spacing: 8) {
//                            Text("Date")
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            Spacer()
//                            DatePicker("", selection: $date, displayedComponents: .date)
//                                .datePickerStyle(.compact)
//                                .labelsHidden()
//                        }
//                        .padding()
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                    }
//                    VStack {
//                        VStack(alignment: .leading, spacing: 8) {
//                            VStack(spacing: 20) {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                                        .frame(maxWidth: .infinity, maxHeight: 200)
//                                    VStack {
//                                        
//                                    }
//                                    .frame(width: 200, height: 200)
//                                    .background(
//                                        Group {
//                                            if FileManager.default.fileExists(atPath: background) {
//                                                Image(uiImage: UIImage(contentsOfFile: background) ?? UIImage())
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(maxWidth: .infinity, maxHeight: 200)
//                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                                            } else {
//                                                Text("Upload Image (Optional)")
//                                                    .font(.subheadline)
//                                                    .foregroundColor(.secondary)
//                                            }
//                                        }
//                                    )
//                                }
//                                HStack(spacing: 20) {
//                                    CameraButton(imagePath: $background)
//                                    PictureButton(imagePath: $background)
//                                }
//                            }
//                        }
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color(UIColor.systemBackground))
//                        .clipShape(RoundedRectangle(cornerRadius: 15))
//                        .shadow(color: Color.primary.opacity(0.3), radius: 6, x: 0, y: 2)
//                        .frame(maxWidth: .infinity)
//                    }
//                }
//                .padding(.horizontal, 15)
//                Button("Save Meeting") {
//                    if let maxOrderMeeting = meetings.max(by: { $0.order < $1.order }) {
//                        order = maxOrderMeeting.order + 1
//                    }
//                    context.insert(
//                        Meeting(
//                            order: order,
//                            topic: topic,
//                            date: date,
//                            descriptions: descriptions,
//                            conclusion: conclusion,
//                            favorite: favorite,
//                            background: background,
//                            sessions: []
//                        )
//                    )
//                    dismiss()
//                }
//                .foregroundColor(Color.white)
//                .frame(width: 200)
//                .padding(.vertical, 8)
//                .background(Color.blue)
//                .cornerRadius(8)
//            }
//        }
//    }
//}
//
//#Preview {
//    AddMeetingView()
//}



//
//  AddMeetingView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//
//
//  AddMeetingView.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 06/04/25.
//
//
//import SwiftUI
//import SwiftData
//
//struct AddMeetingView: View {
//    @Environment(\.modelContext) private var context
//    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]
//
//    @State private var order: Int = 0
//    @State private var topic: String = ""
//    @State private var date: Date = Date()
//    @State private var descriptions: String = ""
//    @State private var conclusion: String = ""
//    @State private var favorite: Bool = false
//    @State private var background: String = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "orange", "blue"].randomElement()!
//    @State private var sessions: [Session] = []
//
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 15) {
//                Text("Add Meeting")
//                    .font(.title.bold())
//                    .padding(.top, 10)
//
//                textInputCard(title: "Meeting Topic", text: $topic, placeholder: "Enter topic")
//
//                formCard {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Meeting Date")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                        DatePicker("", selection: $date, displayedComponents: .date)
//                            .datePickerStyle(.compact)
//                            .labelsHidden()
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//
//                formCard {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Meeting Cover")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 12)
//                                .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
//                                .frame(height: 200)
//                                .background(
//                                    Group {
//                                        if FileManager.default.fileExists(atPath: background) {
//                                            Image(uiImage: UIImage(contentsOfFile: background) ?? UIImage())
//                                                .resizable()
//                                                .scaledToFill()
//                                        } else {
//                                            VStack(spacing: 5) {
//                                                Image(systemName: "photo.on.rectangle.angled")
//                                                    .font(.system(size: 30))
//                                                    .foregroundColor(.secondary)
//                                                Text("Upload Image (Optional)")
//                                                    .font(.footnote)
//                                                    .foregroundColor(.secondary)
//                                            }
//                                        }
//                                    }
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                        }
//                        HStack(spacing: 20) {
//                            Spacer()
//                            CameraButton(imagePath: $background)
//                            PictureButton(imagePath: $background)
//                            Spacer()
//                        }
//                    }
//                }
//                
//                Button(action: saveMeeting) {
//                    Text("Save Meeting")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: 200)
//                        .padding(.vertical, 8)
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//
//    @ViewBuilder
//    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
//        VStack {
//            content()
//        }
//        .padding()
//        .background(Color(.secondarySystemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 15))
//        .shadow(color: Color.primary.opacity(0.05), radius: 4, x: 0, y: 2)
//    }
//
//    @ViewBuilder
//    private func textInputCard(title: String, text: Binding<String>, placeholder: String) -> some View {
//        formCard {
//            VStack(alignment: .leading, spacing: 8) {
//                Text(title)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                TextField(placeholder, text: text)
//                    .padding(10)
//                    .background(Color(.tertiarySystemBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                    .autocorrectionDisabled()
//            }
//        }
//    }
//
//    private func saveMeeting() {
//        if let maxOrderMeeting = meetings.max(by: { $0.order < $1.order }) {
//            order = maxOrderMeeting.order + 1
//        }
//        context.insert(
//            Meeting(
//                order: order,
//                topic: topic,
//                date: date,
//                descriptions: descriptions,
//                conclusion: conclusion,
//                favorite: favorite,
//                background: background,
//                sessions: []
//            )
//        )
//        dismiss()
//    }
//}
//
//#Preview {
//    AddMeetingView()
//}


import SwiftUI
import SwiftData

struct AddMeetingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Meeting.order, order: .reverse) var meetings: [Meeting]

    @State private var order: Int = 0
    @State private var topic: String = ""
    @State private var date: Date = Date()
    @State private var descriptions: String = ""
    @State private var conclusion: String = ""
    @State private var favorite: Bool = false
    @State private var background: String = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "orange", "blue"].randomElement()!
    @State private var sessions: [Session] = []

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                Text("Add Meeting")
                    .font(.title2.bold())
                    .padding(.top, 8)

                textInputCard(title: "Meeting Topic", text: $topic, placeholder: "Enter topic")

                formCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Meeting Date")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }
                }

                formCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Meeting Cover")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                                .frame(height: 160)
                                .background(
                                    Group {
                                        if FileManager.default.fileExists(atPath: background) {
                                            Image(uiImage: UIImage(contentsOfFile: background) ?? UIImage())
                                                .resizable()
                                                .scaledToFill()
                                        } else {
                                            VStack(spacing: 4) {
                                                Image(systemName: "photo.on.rectangle.angled")
                                                    .font(.system(size: 28))
                                                    .foregroundColor(.secondary)
                                                Text("Upload Image (Optional)")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        HStack {
                            Spacer()
                            CameraButton(imagePath: $background)
                            PictureButton(imagePath: $background)
                            Spacer()
                        }
                    }
                }

                Button(action: saveMeeting) {
                    Text("Save Meeting")
                        .foregroundColor(.white)
                        .frame(maxWidth: 160)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack { content() }
            .padding(10)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.primary.opacity(0.05), radius: 2, x: 0, y: 1)
    }

    @ViewBuilder
    private func textInputCard(title: String, text: Binding<String>, placeholder: String) -> some View {
        formCard {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField(placeholder, text: text)
                    .padding(8)
                    .background(Color(.tertiarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .autocorrectionDisabled()
            }
        }
    }

    private func saveMeeting() {
        if let maxOrderMeeting = meetings.max(by: { $0.order < $1.order }) {
            order = maxOrderMeeting.order + 1
        }
        context.insert(
            Meeting(
                order: order,
                topic: topic,
                date: date,
                descriptions: descriptions,
                conclusion: conclusion,
                favorite: favorite,
                background: background,
                sessions: []
            )
        )
        dismiss()
    }
}

#Preview {
    AddMeetingView()
}
