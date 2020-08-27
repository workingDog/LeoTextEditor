//
//  ContentView.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/23.
//

import SwiftUI

struct ContentView: View {
    
    let w = UIScreen.main.bounds.width * CGFloat(0.95)
    let h = UIScreen.main.bounds.height * CGFloat(0.5)
    
    @State var text = """
            {
            "text": "some example text",
            "attributes": [ {
                "location": 0,
                "length": 17,
                "fontType": "title",
                "name": "NSFont"
            } ]
            }
        """

    var body: some View {
        VStack {
            Spacer()
            LeoTextEditor(text: $text, width: w, height: h, simple: false)
                .frame(width: w, height: h)
                .background(RoundedRectangle(cornerRadius: 7)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color.primary)
                                .padding(2))
            Spacer()
        }
    }
    
}
