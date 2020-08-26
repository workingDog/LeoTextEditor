//
//  TextFormatDropDown.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/25.
//

import SwiftUI


struct TextFormatDropDown: View {
    
    var editor: LEOTextView
    
    // button size
    let sx = CGFloat(20)
    // button color
    let color = Color.blue
    
    @State var expand = false
    
    @State var dash = false
    @State var bullet = false
    @State var number = false
    
    let onSelection: () -> Void      // action when selected
    let onDeselection: () -> Void    // action when deselected
    
    init(editor: LEOTextView, onSelection: @escaping () -> Void, onDeselection: @escaping () -> Void) {
        self.editor = editor
        self.onSelection = onSelection
        self.onDeselection = onDeselection
    }
    
    var body: some View {
        Group {
            Button(action: {
                expand.toggle()
                if expand {onSelection()}
                if !expand {onDeselection()}
            }) {
                Image(systemName: "textformat").resizable().frame(width: sx, height: sx)
                    .foregroundColor(expand ? .red : color)
            }.buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
            
            GeometryReader { geo in
                if expand {
                    VStack (alignment: .leading, spacing: 10) {
                        HStack {
                            Button(action: { dash.toggle();
                                editor.doFormatButtonAction(.dashedList)
                                bullet = false
                                number = false
                            }) {
                                Image(systemName: "list.dash").resizable().frame(width: sx, height: sx).foregroundColor(color)
                            }.scaleEffect(dash ? 1.2 : 1.0)
                            Text("dash").font(.caption).foregroundColor(color)
                        }
                        HStack {
                            Button(action: { bullet.toggle();
                                editor.doFormatButtonAction(.bulletedList)
                                dash = false
                                number = false
                            }) {
                                Image(systemName: "list.bullet").resizable().frame(width: sx, height: sx).foregroundColor(color)
                            }.scaleEffect(bullet ? 1.2 : 1.0)
                            Text("bullet").font(.caption).foregroundColor(color)
                        }
                        HStack {
                            Button(action: { number.toggle();
                                editor.doFormatButtonAction(.numberedList)
                                dash = false
                                bullet = false
                            }) {
                                Image(systemName: "list.number").resizable().frame(width: sx, height: sx).foregroundColor(color)
                            }.scaleEffect(number ? 1.2 : 1.0)
                            Text("number").font(.caption).foregroundColor(color)
                        }
                    }.frame(width: 120, height: 160)
                    .buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
                    .padding(.top, 20)
                    .background(RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .background(Color(UIColor.systemGray6))
                                    .padding(2))
                }
            }
        }
    }
    
}
