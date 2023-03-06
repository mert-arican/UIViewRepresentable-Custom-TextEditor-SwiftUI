//
//  CustomTextEditor.swift
//  FelixData
//
//  Created by Mert Arıcan on 2.03.2023.
//

import Foundation
import SwiftUI
import AppKit

class HTMLFormatter: StringFormatter {
        func format(string: String) -> NSAttributedString? {
            guard let data = string.data(using: .utf8),
                  let attributedText = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            else { return nil }
            
            return attributedText
        }
    }

struct CustomTextEditor: NSViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    @Binding var text: String
    
    func makeNSView(context: Context) -> NSTextView {
        let textfield = NSTextView()
        textfield.delegate = context.coordinator
        textfield.backgroundColor = .green
        return textfield
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        let selectedRange = nsView.selectedRange()
        nsView.textContainer?.textView?.string = text
        nsView.selectedRange = selectedRange
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CustomTextEditor
        
        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChangeSelection(_ notification: Notification) {
            Cons.asd = (notification.object as? NSTextView)?.selectedRange().length ?? -1
            print((notification.object as? NSTextView)?.selectedRange(), "HHH")
        }
        
        func textDidChange(_ notification: Notification) {
            DispatchQueue.main.async {
                if let text = (notification.object as? NSTextView)?.string {
                    self.parent.$text.wrappedValue = text
                    print(self.parent.$text.wrappedValue.hasPrefix("\t"))
                }
            }
        }
    }
}

//extension CustomTextEditor.Coordinator: NSControlTextEditingDelegate {
//    override func controlTextDidChange(_ notification: Notification) {
//        if let textField = notification.object as? NSTextField {
//            print(textField.stringValue)
//            //do what you need here
//        }
//    }
//}
