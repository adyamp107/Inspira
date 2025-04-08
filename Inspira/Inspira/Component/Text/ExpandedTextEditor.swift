////
////  ExpandedTextEditor.swift
////  Inspira
////
////  Created by Adya Muhammad Prawira on 06/04/25.
////
//
//import SwiftUI
//
//struct ExpandedTextEditor: View {
//    let title: String
//    @Binding var text: String
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextEditor(text: $text)
//                    .padding()
//                    .navigationTitle(title)
//                    .toolbar {
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button("Done") {
//                                dismiss()
//                            }
//                        }
//                    }
//            }
//        }
//    }
//}

//#Preview {
//    @Previewable @State var text = ""
//    ExpandedTextEditor(title: "Test", text: $text)
//}
//

import SwiftUI

struct ExpandedTextEditor: View {
    let title: String
    let allSessionNotes: String
    @Binding var text: String
    @Environment(\.dismiss) var dismiss
    @State private var showCopiedAlert = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(10)
                    .frame(maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                VStack(alignment: .leading, spacing: 8) {
                    Text("Word count: \(text.split(separator: " ").count)")
                    Text("Character count: \(text.count)")
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                
                HStack {
                    Button(action: {
                        text = ""
                    }) {
                        Label("Clear", systemImage: "trash")
                            .padding(10)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        insertTemplate()
                    }) {
                        Label("Insert Template", systemImage: "doc.text")
                            .padding(10)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        UIPasteboard.general.string = text
                        showCopiedAlert = true
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .padding(10)
                            .background(Color.green.opacity(0.1))
                            .foregroundColor(.green)
                            .cornerRadius(8)
                    }
                }
                
                if title == "Conclusion" {
                    HStack {
                        Spacer()
                        Button(action: {
                            text += allSessionNotes
                        }) {
                            Text("Add Session Notes")
                                .foregroundColor(.white)
                                .frame(maxWidth: 200)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        Spacer()
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $showCopiedAlert) {
                Alert(title: Text("Copied!"), message: Text("Text has been copied to clipboard."), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func insertTemplate() {
        if title == "Descriptions" {
            text += "\n===================\n• Descriptions Template •\n===================\n\n• Background:\n\n• Goals:\n\n• Rules:\n\n• Stakeholders:\n\n• Notes:\n"
        } else if title == "Conclusion" {
            text += "\n==================\n• Conclusion Template •\n==================\n\n• Decision:\n\n• Key Points:\n\n• Next Steps:\n"
        } else {
            text += "\n==============\n• Notes Template •\n==============\n\n• Point 1:\n\n• Point 2:\n\n• Point 3:\n"
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    ExpandedTextEditor(title: "Conclusion", allSessionNotes: "sdcsdcs", text: $text)
}

//
//import SwiftUI
//
//struct ExpandedTextEditor: View {
//    let title: String
//    @Binding var text: String
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 16) {
//                TextEditor(text: $text)
//                    .scrollContentBackground(.hidden)
//                    .background(Color(.tertiarySystemBackground))
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                    .frame(maxHeight: .infinity)
//
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Word count: \(text.split { $0.isWhitespace || $0.isNewline }.count)")
//                    Text("Character count: \(text.count)")
//                }
//                .font(.footnote)
//                .foregroundColor(.secondary)
//                .padding(.horizontal)
//
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 8) {
//                        Button(action: insertTemplate) {
//                            toolButtonLabel("Insert Template", systemImage: "doc.text", color: .blue)
//                        }
//
//                        Button(action: convertToBulletList) {
//                            toolButtonLabel("Bullets", systemImage: "list.bullet", color: .indigo)
//                        }
//
//                        Button(action: convertToNumberedList) {
//                            toolButtonLabel("Numbered", systemImage: "list.number", color: .orange)
//                        }
//
//                        Button(action: capitalizeSentences) {
//                            toolButtonLabel("Capitalize", systemImage: "textformat.size", color: .green)
//                        }
//
//                        Button(action: { text = text.lowercased() }) {
//                            toolButtonLabel("Lowercase", systemImage: "textformat.abc", color: .teal)
//                        }
//
//                        Button(action: { text = text.uppercased() }) {
//                            toolButtonLabel("Uppercase", systemImage: "textformat", color: .purple)
//                        }
//
//                        Button(action: appendTimestamp) {
//                            toolButtonLabel("Timestamp", systemImage: "calendar", color: .gray)
//                        }
//                        
//                        Button(action: { text = "" }) {
//                            toolButtonLabel("Clear", systemImage: "trash", color: .red)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//                Spacer(minLength: 16)
//            }
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Done") {
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//
//    private func insertTemplate() {
//        if title == "Descriptions" {
//            text += "\n\n• Background:\n• Goals:\n• Stakeholders:\n• Notes:"
//        } else if title == "Conclusion" {
//            text += "\n\n✅ Decision:\n📝 Key Points:\n📌 Next Steps:"
//        } else {
//            text += "\n\n• Point 1\n• Point 2\n• Point 3"
//        }
//    }
//
//    private func convertToBulletList() {
//        let lines = text.split(separator: "\n").map { "• \($0.trimmingCharacters(in: .whitespaces))" }
//        text = lines.joined(separator: "\n")
//    }
//
//    private func convertToNumberedList() {
//        let lines = text.split(separator: "\n")
//        text = lines.enumerated().map { "\($0 + 1). \($1.trimmingCharacters(in: .whitespaces))" }.joined(separator: "\n")
//    }
//
//    private func capitalizeSentences() {
//        let sentences = text.split(omittingEmptySubsequences: false, whereSeparator: { ".!?".contains($0) })
//        text = sentences
//            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).capitalizedSentence() }
//            .joined(separator: ". ")
//    }
//
//    private func appendTimestamp() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        text += "\n\n🕒 \(formatter.string(from: Date()))"
//    }
//
//    private func toolButtonLabel(_ title: String, systemImage: String, color: Color) -> some View {
//        Label(title, systemImage: systemImage)
//            .padding(10)
//            .background(color.opacity(0.1))
//            .foregroundColor(color)
//            .cornerRadius(8)
//    }
//}
//
//private extension String {
//    func capitalizedSentence() -> String {
//        guard let first = self.first else { return self }
//        return first.uppercased() + self.dropFirst()
//    }
//}

//
//import SwiftUI
//
//struct ExpandedTextEditor: View {
//    let title: String
//    @Binding var text: String
//    @Environment(\.dismiss) var dismiss
//    @State private var selectedRange: NSRange = .init(location: 0, length: 0)
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 16) {
//                TextViewWrapper(text: $text, selectedRange: $selectedRange)
//                    .frame(maxHeight: .infinity)
//                    .padding(.horizontal)
//
//                wordAndCharCountView
//
//                writingToolsBar
//
//            }
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Done") { dismiss() }
//                }
//            }
//        }
//    }
//
//    private var wordAndCharCountView: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text("Word count: \(text.split { $0.isWhitespace || $0.isNewline }.count)")
//            Text("Character count: \(text.count)")
//        }
//        .font(.footnote)
//        .foregroundColor(.secondary)
//        .padding(.horizontal)
//    }
//
//    private var writingToolsBar: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 8) {
//                tool("Insert Template", "doc.text", .blue) { insertTemplate() }
//                tool("Bullets", "list.bullet", .indigo) { toggleBullets() }
//                tool("Numbered", "list.number", .orange) { toggleNumbered() }
//                tool("Capitalize", "textformat", .green) { applyStyle(.capitalize) }
//                tool("Lowercase", "textformat.abc", .teal) { applyStyle(.lowercase) }
//                tool("Uppercase", "textformat.size", .purple) { applyStyle(.uppercase) }
//                tool("Timestamp", "calendar", .gray) { appendTimestamp() }
//                tool("Clear", "trash", .red) { text = "" }
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 12)
//        }
//    }
//
//    private func tool(_ title: String, _ systemImage: String, _ color: Color, action: @escaping () -> Void) -> some View {
//        Button(action: action) {
//            Label(title, systemImage: systemImage)
//                .padding(10)
//                .background(color.opacity(0.1))
//                .foregroundColor(color)
//                .cornerRadius(8)
//        }
//    }
//
//    // MARK: - Text Manipulations
//
//    private func applyStyle(_ style: TextStyle) {
//        let nsText = text as NSString
//        let range = selectedRange.length > 0 ? selectedRange : NSRange(location: 0, length: nsText.length)
//        let selected = nsText.substring(with: range)
//
//        let transformed: String
//        switch style {
//        case .lowercase: transformed = selected.lowercased()
//        case .uppercase: transformed = selected.uppercased()
//        case .capitalize: transformed = selected.capitalized
//        }
//
//        text = nsText.replacingCharacters(in: range, with: transformed)
//    }
//
//    private func toggleBullets() {
//        toggleList { line, _ in
//            line.hasPrefix("• ") ? String(line.dropFirst(2)) : "• \(line)"
//        }
//    }
//
//    private func toggleNumbered() {
//        toggleList { line, index in
//            let pattern = #"^\d+\. "#
//            if let range = line.range(of: pattern, options: .regularExpression) {
//                return String(line[range.upperBound...])
//            } else {
//                return "\(index + 1). \(line)"
//            }
//        }
//    }
//
//    private func toggleList(_ transform: (String, Int) -> String) {
//        let nsText = text as NSString
//        let range = selectedRange.length > 0 ? selectedRange : NSRange(location: 0, length: nsText.length)
//        let selected = nsText.substring(with: range)
//        let lines = selected.components(separatedBy: .newlines)
//        let transformedLines = lines.enumerated().map { index, line in
//            transform(line, index)
//        }
//        let transformedText = transformedLines.joined(separator: "\n")
//        text = nsText.replacingCharacters(in: range, with: transformedText)
//    }
//
//    private func insertTemplate() {
//        let template: String
//        if title == "Descriptions" {
//            template = "\n\n• Background:\n• Goals:\n• Stakeholders:\n• Notes:"
//        } else if title == "Conclusion" {
//            template = "\n\n✅ Decision:\n📝 Key Points:\n📌 Next Steps:"
//        } else {
//            template = "\n\n• Point 1\n• Point 2\n• Point 3"
//        }
//        text += template
//    }
//
//    private func appendTimestamp() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        text += "\n\n🕒 \(formatter.string(from: Date()))"
//    }
//
//    enum TextStyle {
//        case lowercase, uppercase, capitalize
//    }
//}
//
//struct TextViewWrapper: UIViewRepresentable {
//    @Binding var text: String
//    @Binding var selectedRange: NSRange
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.delegate = context.coordinator
//        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.backgroundColor = UIColor.tertiarySystemBackground
//        textView.layer.cornerRadius = 10
//        textView.isScrollEnabled = true
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        if uiView.text != text {
//            uiView.text = text
//        }
//        uiView.selectedRange = selectedRange
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextViewDelegate {
//        var parent: TextViewWrapper
//
//        init(_ parent: TextViewWrapper) {
//            self.parent = parent
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            parent.text = textView.text
//        }
//
//        func textViewDidChangeSelection(_ textView: UITextView) {
//            parent.selectedRange = textView.selectedRange
//        }
//    }
//}
//
//
//#Preview {
//    @Previewable @State var text = ""
//    ExpandedTextEditor(title: "Test", text: $text)
//}
//
//import SwiftUI
//
//struct ExpandedTextEditorf: View {
//    let title: String
//    @Binding var attributedText: NSAttributedString
//    @Environment(\.dismiss) var dismiss
//    @State private var selectedRange: NSRange = NSRange(location: 0, length: 0)
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 16) {
//                AttributedTextView(text: $attributedText, selectedRange: $selectedRange)
//                    .frame(maxHeight: .infinity)
//                    .padding(.horizontal)
//
//                wordAndCharCount
//
//                writingToolbar
//            }
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Done") {
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//
//    private var wordAndCharCount: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text("Words: \(attributedText.string.split { $0.isWhitespace || $0.isNewline }.count)")
//            Text("Characters: \(attributedText.string.count)")
//        }
//        .font(.footnote)
//        .foregroundColor(.secondary)
//        .padding(.horizontal)
//    }
//
//    private var writingToolbar: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 8) {
//                tool("Bold", "bold", .black) { toggleStyle(.bold) }
//                tool("Italic", "italic", .gray) { toggleStyle(.italic) }
//                tool("Underline", "underline", .blue) { toggleStyle(.underline) }
//                tool("Bullets", "list.bullet", .indigo) { toggleBullets() }
//                tool("Numbered", "list.number", .orange) { toggleNumbered() }
//                tool("Checklist", "checklist", .green) { toggleChecklist() }
//
//                tool("Lower", "textformat.abc", .teal) { transformText(.lowercase) }
//                tool("Upper", "textformat", .purple) { transformText(.uppercase) }
//                tool("Cap", "textformat.size", .pink) { transformText(.capitalize) }
//
//                tool("Template", "doc.text", .blue) { insertTemplate() }
//                tool("Time", "calendar", .gray) { insertTimestamp() }
//
//                tool("Clear", "trash", .red) { attributedText = NSAttributedString(string: "") }
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 12)
//        }
//    }
//
//    private func tool(_ title: String, _ systemImage: String, _ color: Color, action: @escaping () -> Void) -> some View {
//        Button(action: action) {
//            Label(title, systemImage: systemImage)
//                .padding(10)
//                .background(color.opacity(0.1))
//                .foregroundColor(color)
//                .cornerRadius(8)
//        }
//    }
//
//    private func toggleStyle(_ style: TextStyle) {
//        let mutable = NSMutableAttributedString(attributedString: attributedText)
//        let range = selectedRange
//        switch style {
//        case .bold:
//            mutable.toggleTrait(.traitBold, in: range)
//        case .italic:
//            mutable.toggleTrait(.traitItalic, in: range)
//        case .underline:
//            mutable.toggleUnderline(in: range)
//        }
//        attributedText = mutable
//    }
//
//    private func transformText(_ style: TextTransformStyle) {
//        let mutable = NSMutableAttributedString(attributedString: attributedText)
//        let range = selectedRange
//        let original = mutable.attributedSubstring(from: range).string
//
//        let transformed: String
//        switch style {
//        case .lowercase: transformed = original.lowercased()
//        case .uppercase: transformed = original.uppercased()
//        case .capitalize: transformed = original.capitalized
//        }
//
//        mutable.replaceCharacters(in: range, with: NSAttributedString(string: transformed))
//        attributedText = mutable
//    }
//
//    private func toggleBullets() {
//        toggleList(prefix: "• ")
//    }
//
//    private func toggleNumbered() {
//        toggleList(prefix: nil, isNumbered: true)
//    }
//
//    private func toggleChecklist() {
//        toggleList(prefix: "☐ ")
//    }
//
//    private func toggleList(prefix: String?, isNumbered: Bool = false) {
//        let mutable = NSMutableAttributedString(attributedString: attributedText)
//        let range = selectedRange
//        let selected = mutable.attributedSubstring(from: range).string
//        let lines = selected.components(separatedBy: .newlines)
//
//        let transformedLines = lines.enumerated().map { (i, line) -> String in
//            if isNumbered {
//                let regex = #"^\d+\.\s"# // detect "1. "
//                if line.range(of: regex, options: .regularExpression) != nil {
//                    return String(line.drop { $0 != " " }) // remove number prefix
//                } else {
//                    return "\(i + 1). \(line)"
//                }
//            } else if let prefix = prefix {
//                if line.hasPrefix(prefix) {
//                    return String(line.dropFirst(prefix.count))
//                } else {
//                    return "\(prefix)\(line)"
//                }
//            } else {
//                return line
//            }
//        }
//
//        let newText = transformedLines.joined(separator: "\n")
//        mutable.replaceCharacters(in: range, with: NSAttributedString(string: newText))
//        attributedText = mutable
//    }
//
//    private func insertTemplate() {
//        let template: String
//        switch title {
//        case "Descriptions":
//            template = "\n\n• Background:\n• Goals:\n• Stakeholders:\n• Notes:"
//        case "Conclusion":
//            template = "\n\n✅ Decision:\n📝 Key Points:\n📌 Next Steps:"
//        default:
//            template = "\n\n• Point 1\n• Point 2\n• Point 3"
//        }
//
//        let mutable = NSMutableAttributedString(attributedString: attributedText)
//        mutable.append(NSAttributedString(string: template))
//        attributedText = mutable
//    }
//
//    private func insertTimestamp() {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .short
//        let timestamp = "\n🕒 \(formatter.string(from: Date()))\n"
//        let mutable = NSMutableAttributedString(attributedString: attributedText)
//        mutable.append(NSAttributedString(string: timestamp))
//        attributedText = mutable
//    }
//
//    enum TextStyle { case bold, italic, underline }
//    enum TextTransformStyle { case lowercase, uppercase, capitalize }
//}
//
//// MARK: - UIKit wrapper
//struct AttributedTextView: UIViewRepresentable {
//    @Binding var text: NSAttributedString
//    @Binding var selectedRange: NSRange
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.delegate = context.coordinator
//        textView.isScrollEnabled = true
//        textView.backgroundColor = UIColor.tertiarySystemBackground
//        textView.font = .systemFont(ofSize: 17)
//        textView.layer.cornerRadius = 10
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        if uiView.attributedText != text {
//            uiView.attributedText = text
//        }
//        if uiView.selectedRange != selectedRange {
//            uiView.selectedRange = selectedRange
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextViewDelegate {
//        var parent: AttributedTextView
//
//        init(_ parent: AttributedTextView) {
//            self.parent = parent
//        }
//
//        func textViewDidChange(_ textView: UITextView) {
//            parent.text = textView.attributedText
//        }
//
//        func textViewDidChangeSelection(_ textView: UITextView) {
//            parent.selectedRange = textView.selectedRange
//        }
//    }
//}
//
//// MARK: - NSAttributedString helpers
//extension NSMutableAttributedString {
//    func toggleTrait(_ trait: UIFontDescriptor.SymbolicTraits, in range: NSRange) {
//        enumerateAttribute(.font, in: range, options: []) { value, subrange, _ in
//            guard let font = value as? UIFont else { return }
//            var traits = font.fontDescriptor.symbolicTraits
//            if traits.contains(trait) {
//                traits.remove(trait)
//            } else {
//                traits.insert(trait)
//            }
//
//            if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
//                let newFont = UIFont(descriptor: descriptor, size: font.pointSize)
//                addAttribute(.font, value: newFont, range: subrange)
//            }
//        }
//    }
//
//    func toggleUnderline(in range: NSRange) {
//        enumerateAttribute(.underlineStyle, in: range, options: []) { value, subrange, _ in
//            let current = value as? Int ?? 0
//            let new = current == 0 ? NSUnderlineStyle.single.rawValue : 0
//            addAttribute(.underlineStyle, value: new, range: subrange)
//        }
//    }
//}
//
//#Preview {
//    @Previewable @State var attrText = NSAttributedString(string: "")
//    return ExpandedTextEditorf(title: "Test", attributedText: $attrText)
//}
