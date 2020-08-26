//
//  LeoEditorView.swift
//  LeoTextEditor
//
//  Created by Ringo Wathelet on 2020/08/23.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct LeoEditorView: UIViewRepresentable {
    
    var editor: LEOTextView
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> LEOTextView {
        editor.delegate = context.coordinator
        editor.becomeFirstResponder()
        return editor
    }
    
    func updateUIView(_ uiView: LEOTextView, context: Context) { }
    
    func updateUIViewController(_ uiViewController: LEOTextView, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: LeoEditorView
        
        init(_ editor: LeoEditorView) {
            parent = editor
            super.init()
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = parent.editor.textAttributesJSON() 
        }
        
        public func textViewDidEndEditing(_ textView: UITextView) {
            parent.text = parent.editor.textAttributesJSON()
        }
        
    }
    
}
