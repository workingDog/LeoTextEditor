//
//  LeoTextEditor.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/23.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI


struct LeoTextEditor: View {
    
    let width: CGFloat
    let height: CGFloat
    
    // true for a simple toolbar, false for a more advanced toolbar
    var simple = true
    
    let sx = CGFloat(20)
    // adjusting for iPhone and iPad/mac
    let d = LeoToolbar.isPhone ? CGFloat(0) : CGFloat(40)
    
    let editor = LEOTextView()
    
    // text contains all the json attributes
    @Binding var text: String
    // to display the toolbar or not
    var withToolbar = true
    // control keyboard display, internal use
    @State private var keyboardOn = false
    
    
    init(text: Binding<String>, withToolbar: Bool = true, width: CGFloat, height: CGFloat, simple: Bool = true) {
        self._text = text
        self.withToolbar = withToolbar
        self.width = width
        self.height = height
        self.simple = simple
    }
    
    var body: some View {
        simple ? AnyView(withSimpleToolbar) : AnyView(withAdvancedToolbar)
    }
    
    var withSimpleToolbar: some View {
            VStack (alignment: .leading) {
                if withToolbar {
                    LeoToolbarSimple(editor: editor)
                }
                Divider().padding(.horizontal, 10)
                ScrollView {
                    LeoEditorView(editor: editor, text: $text)
                        .padding(.horizontal, 15)
                        .frame(width: width, height: height)
                        .onTapGesture {showKeyboard()}
                }
            }.onAppear(perform: loadData)
            .padding(5)
    }
    
    var withAdvancedToolbar: some View {
        ZStack {
            VStack (alignment: .leading) {
                GeometryReader { geo in
                    if withToolbar {
                        let geoPoint = geo.frame(in: .local).origin
                        let dy = geoPoint.y + sx
                        let dx = geoPoint.x + d
                        LeoToolbar(editor: editor).zIndex(3)
                            .overlay(
                                VStack {
                                    FontDropDown(editor: editor).zIndex(4).padding(.top, 10)
                                }.position(x: 250 + dx, y: dy), alignment: .trailing)
                            .overlay(
                                VStack {
                                    TextFormatDropDown(editor: editor).zIndex(4).padding(.top, 10)
                                }.position(x: 290 + dx, y: dy), alignment: .trailing)
                            .overlay(
                                VStack {
                                    HighlightDropDown(editor: editor).zIndex(4).padding(.top, 10)
                                }.position(x: 330 + dx, y: dy), alignment: .trailing)
                    }
                }.frame(height: 45).zIndex(2)
                Divider().padding(.horizontal, 10)
                ScrollView {
                    LeoEditorView(editor: editor, text: $text)
                        .padding(.horizontal, 15)
                        .frame(width: width, height: height)
                        .onTapGesture {showKeyboard()}
                }.padding(.top, 5)
            }.onAppear(perform: loadData)
            .padding(5)
        }
    }
    
    func loadData() {
        // initially hide the keyboard
        editor.resignFirstResponder()
        // give the initial text to the editor
        editor.setAttributeTextWithJSONString(text)
    }
    
    func showKeyboard() {
        keyboardOn.toggle()
        let _ = keyboardOn ? editor.becomeFirstResponder() : editor.resignFirstResponder()
    }
}
