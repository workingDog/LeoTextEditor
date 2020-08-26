//
//  LeoToolbarSimple.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/25.
//

import SwiftUI

struct LeoToolbarSimple: View {
    
    var editor: LEOTextView
    
    // button size
    let sx = CGFloat(20)
    // button color
    let color = Color.blue
    let d = LeoToolbar.isPhone ? CGFloat(0) : CGFloat(60)
    
    @State private var txtColor = Color.black
    @State private var highColor = Color.clear
    
    @State var dash = false
    @State var bullet = false
    @State var number = false
    
    static let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack (spacing: LeoToolbar.isPhone ? 5 : 10) {
                Spacer()
                Button(action: { editor.clearButtonAction() }) {
                    Image(systemName: "flame").resizable().frame(width: sx, height: sx).foregroundColor(.pink)
                }
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
                textFormats
                textColorButton
                highlighter
            }.buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
            
        }.frame(width: 400 + d, height: 80 + d/2)
    }
    
    var textFormats: some View {
        VStack (spacing: 2) {
            
            Button(action: { dash.toggle();
                editor.doFormatButtonAction(.dashedList)
                bullet = false
                number = false
            }) {
                Text("- dash").font(.caption).foregroundColor(color)
            }
            
            Button(action: { bullet.toggle();
                editor.doFormatButtonAction(.bulletedList)
                dash = false
                number = false
            }) {
                Text(". bullet").font(.caption).foregroundColor(color)
            }
            
            Button(action: { number.toggle();
                editor.doFormatButtonAction(.numberedList)
                dash = false
                bullet = false
            }) {
                Text("1. number").font(.caption).foregroundColor(color)
            }
            
        }.buttonStyle(GrayButtonStyle(w: 80, h: 20 + d/6))
        .padding(.top, 5)
    }
    
    var textColorButton: some View {
        VStack {
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
            Text("Text").font(.caption).foregroundColor(.black)
        }
    }
    
    var highlighter: some View {
        VStack {
            ColorPicker("Highlight color", selection: Binding<Color> (
                get: { highColor },
                set: {
                    highColor = $0
                    #if !targetEnvironment(macCatalyst)
                    let uicolor = UIColor(highColor)
                    editor.highlightButtonAction(uicolor)
                    #endif
                    // NSColor(Color.red)  // todo for macos
                }
            )).labelsHidden()
            Text("Highlight").font(.caption).foregroundColor(.black)
        }
    }
    
}

