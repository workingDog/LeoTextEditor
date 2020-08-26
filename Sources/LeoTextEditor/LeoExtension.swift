//
//  LeoExtension.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/23.
//

import Foundation
import UIKit
import SwiftUI


// from the original LEOTextView -> String+Length.swift
extension String {
    // Return real length of String. it's not absolute equal String.characters.count
    func length() -> Int {
        return NSString(string: self).length
    }
}

extension UIFont {
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
}

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        if hexFormatted.count == 6 {
            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: alpha)
        } else {
            self.init(.black)
        }
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255) << 16 | (Int)(g*255) << 8 | (Int)(b*255) << 0
        return String(format:"#%06x", rgb)
    }
}

struct GrayButtonStyle: ButtonStyle {
    let w: CGFloat
    let h: CGFloat
    
    init(w: CGFloat, h: CGFloat) {
        self.w = w
        self.h = h
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .frame(width: w, height: h)
            .padding(3)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(UIColor.systemGray4)]), startPoint: .top, endPoint: .bottom))
            .overlay(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.black, lineWidth: 1))
    }
}
