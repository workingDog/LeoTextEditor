//
//  FontDropDown.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/25.
//

import SwiftUI


struct FontDropDown: View {

    let onSelection: () -> Void      // action when selected
    let onDeselection: () -> Void    // action when deselected
    
    init(editor: LEOTextView, onSelection: @escaping () -> Void, onDeselection: @escaping () -> Void) {
        self.editor = editor
        self.onSelection = onSelection
        self.onDeselection = onDeselection
    }
    
    var editor: LEOTextView
    
    // button size
    let sx = CGFloat(20)
    // button color
    let color = Color.blue
    
    @State var expand = false
    
    @State private var highColor = Color.clear
    

    var body: some View {
        Group {
            Button(action: {
                expand.toggle()
                if expand {onSelection()}
                if !expand {onDeselection()}
            }) {
                Image(systemName: "f.cursive").resizable().frame(width: sx, height: sx)
                    .foregroundColor(expand ? .red : color)
            }.buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
  
            GeometryReader { geo in
                if expand {
                    LeoFontSelector(editor: editor)
                        .frame(width: 280, height: 160)
                        .buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
                        .padding(.top, 10)
                        .background(RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1)
                                        .background(Color(UIColor.systemGray6))
                                        .padding(2))
                } 
            }
        }
    }
    
}
