//
//  CustomTextEditor.swift
//  FelixData
//
//  Created by Mert Arıcan on 2.03.2023.
//

import Foundation
import SwiftUI
import AppKit

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
            let selectedRange = (notification.object as? NSTextView)?.selectedRange()
//            print(selectedRange, "HHH")
            
            let text = (notification.object as? NSTextView)!.string
//            let den = Den(str: text)
//            if let data = den.json {
//                print(String(data: data, encoding: .utf8)!)
//            }
            let low = text.index(text.startIndex, offsetBy: selectedRange!.lowerBound)
            let high = text.index(text.startIndex, offsetBy: selectedRange!.upperBound)
//            print(selectedRange!.lowerBound, selectedRange!.upperBound)
//            print(text[low..<high])
        }
        
        func textDidChange(_ notification: Notification) {
            DispatchQueue.main.async {
                if let text = (notification.object as? NSTextView)?.string {
                    self.parent.$text.wrappedValue = text
                }
            }
        }
    }
}
