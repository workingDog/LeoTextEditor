//
//  LeoFontSelector.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/24.
//

import SwiftUI

struct LeoFontSelector: View {
    
    var editor: LEOTextView
    
    @State private var selectedFontSize = 4
    @State private var fontSizes = ["10","12","14","16","18","20","22","24","28","30","32","34"]
    
    @State private var selectedFont = 147  // HelveticaNeue
    var fontList: [String] {
        var temp = [String]()
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                temp.append(fontName)
            }
        }
        return temp
    }

    var body: some View {
        HStack {
            Picker(selection: Binding<Int>(
                get: { selectedFont },
                set: {
                    selectedFont = $0
                    // todo
 // editor.changeAllFonts(fontName: fontList[selectedFont], fontSize: Int(fontSizes[selectedFontSize]) ?? 17)
                }
            ), label: Text("")) {
                ForEach(0 ..< fontList.count) {
                    Text(self.fontList[$0]).font(.caption)
                }
            }.pickerStyle(DefaultPickerStyle())
            .frame(width: 180, height: 150)
            .clipped()
            
            Spacer()
            
            Picker(selection: Binding<Int>(
                get: { selectedFontSize },
                set: {
                    selectedFontSize = $0
                    editor.changeAllFontSize(fontSize: Int(fontSizes[selectedFontSize]) ?? 17)
                }
            ), label: Text("")) {
                ForEach(0 ..< fontSizes.count) {
                    Text(self.fontSizes[$0]).font(.caption)
                }
            }.pickerStyle(DefaultPickerStyle())
            .frame(width: 70, height: 150)
            .clipped()
        }.frame(width: 270, height: 180)
    }
    
}
