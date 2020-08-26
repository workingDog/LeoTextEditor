//
//  LeoToolbar.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/23.
//  Copyright © 2020 Ringo Wathelet. All rights reserved.
//

import SwiftUI


// part of the more advanced toolbar
struct LeoToolbar: View {
    
    var editor: LEOTextView
    
    // button size
    let sx = CGFloat(20)
    // button color
    let color = Color.blue
    
    @State private var txtColor = Color.black
    @State private var highColor = Color.clear
    
    static let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack (spacing: LeoToolbar.isPhone ? 5 : 10) {
                Spacer()
                Button(action: { editor.clearButtonAction() }) {
                    Image(systemName: "flame").resizable().frame(width: sx, height: sx).foregroundColor(.pink)
                }
                textColorButton
                Button(action: { editor.boldButtonAction() }) {
                    Image(systemName: "bold").resizable().frame(width: sx, height: sx).foregroundColor(color)
                }
                Button(action: { editor.italicButtonAction() }) {
                    Image(systemName: "italic").resizable().frame(width: sx, height: sx).foregroundColor(color)
                }
                Button(action: { editor.strikeButtonAction() }) {
                    Image(systemName: "strikethrough").resizable().frame(width: sx, height: sx).foregroundColor(color)
                }
                Button(action: { editor.underlineButtonAction() }) {
                    Image(systemName: "underline").resizable().frame(width: sx, height: sx).foregroundColor(color)
                }
            }.buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
            .frame(width: LeoToolbar.isPhone ? 220 : 250)
            
        }.frame(width: LeoToolbar.isPhone ? 350 : 400)
    }
    
    var textColorButton: some View {
        ColorPicker("", selection: Binding<Color> (
            get: { txtColor },
            set: {
                txtColor = $0
                #if !targetEnvironment(macCatalyst)
                    let uicolor = UIColor(txtColor)
                    editor.colorButtonAction(uicolor)
                #endif
                // NSColor(Color.red)  // todo for macos
            }
        ))
    }
    
}

