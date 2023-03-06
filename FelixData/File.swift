//
//  File.swift
//  FelixData
//
//  Created by Mert Arıcan on 2.03.2023.
//

import Foundation
import SwiftUI
import AppKit

typealias UITextView = NSTextView

protocol StringFormatter {
    func format(string: String) -> NSAttributedString?
}

struct AttributedText: NSViewRepresentable {
        typealias NSViewType = UITextView
        
        @State
        private var attributedText: NSAttributedString?
        private let text: String
        private let formatter: StringFormatter
        private var delegate: NSTextViewDelegate?
        
        init(_ text: String, _ formatter: StringFormatter, delegate: NSTextViewDelegate? = nil) {
            self.text = text
            self.formatter = formatter
            self.delegate = delegate
        }
        
        func makeNSView(context: Context) -> NSViewType {
            let view = ContentTextView()
            view.setContentHuggingPriority(.required, for: .vertical)
            view.setContentHuggingPriority(.required, for: .horizontal)
            view.textContainerInset = .zero //?
            view.textContainer?.lineFragmentPadding = 0
            view.delegate = delegate
            view.backgroundColor = .clear
            return view
        }
        
        func updateNSView(_ nsView: UITextView, context: Context) {
            guard let attributedText = attributedText else {
                generateAttributedText()
                return
            }
            
            nsView.string = attributedText.string
            nsView.invalidateIntrinsicContentSize()
        }
        
        private func generateAttributedText() {
            guard attributedText == nil else { return }
            // create attributedText on main thread since HTML formatter will crash SwiftUI
            DispatchQueue.main.async {
                self.attributedText = self.formatter.format(string: self.text)
            }
        }
        
        /// ContentTextView
        /// subclass of UITextView returning contentSize as intrinsicContentSize
        private class ContentTextView: UITextView {
//            override var canBecomeFirstResponder: Bool { false }
            override var acceptsFirstResponder: Bool { false }
            
            override var intrinsicContentSize: CGSize {
                frame.height > 0 ? textContainer!.containerSize : super.intrinsicContentSize
            }
        }
    }
