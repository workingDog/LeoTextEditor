//
//  HighlightDropDown.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/25.
//

import SwiftUI


struct HighlightDropDown: View {
    
    var editor: LEOTextView
    
    // button size
    let sx = CGFloat(20)
    // button color
    let color = Color.blue
    
    @State var expand = false
    
    @State private var highColor = Color.clear
    
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
                Image(systemName: "paintbrush").resizable().frame(width: sx, height: sx)
                    .foregroundColor(expand ? .red : color)
            }.buttonStyle(GrayButtonStyle(w: sx+5, h: sx+5))
            .padding(.top, 10)
            
            GeometryReader { geo in
                if expand {
                    VStack (spacing: 10) {
                        Text("Highlight").foregroundColor(.black)
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
                    }.frame(width: 120, height: 100)
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
