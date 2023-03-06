//
//  ContentView.swift
//  FelixData
//
//  Created by Mert Arıcan on 2.03.2023.
//

import SwiftUI
import AppKit

struct Cons {
    static var asd: Int = 0
    static var text: String = ""
}

struct ContentView: View {
    @State private var text: String = "slkdşalskdşalsdkşask"
    @State private var text2: String = "slkdşalskdşalsdkşask"
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...10, id: \.self) { _ in
                    TextEditor(text: $text2)
                        .frame(height: 42.0)
                    
                    CustomTextEditor(text: $text)
                        .frame(width: 200, height: 400.0)
                        .background(.yellow)
                    Button {
                        print(Cons.asd, "RANGE", text)
                    } label: {
                        Text("Tap")
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
    
    private func widthOfTheText(_ text: String) -> CGFloat {
        let attributedString =
        NSAttributedString(
            string: text,
            attributes: [.font : NSFont.systemFont(ofSize: 18.0)]
        )
        return max(80.0, attributedString.size().height)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
