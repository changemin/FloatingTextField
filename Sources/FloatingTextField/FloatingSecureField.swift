//
//  FloatingTextSecureField.swift
//
//
//  Created by 변경민 on 2020/12/22.
//

import SwiftUI

public struct FloatingSecureField: View {
    @Binding public var content: String
    @State var secureContent: String = ""
    @State public var contentType: ContentType = .none
    @State public var placeholder: String = "Placeholder"
    @State public var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    @State public var systemIcon: String = ""
    @State public var showClearButton: Bool = true
    @State private var currentTextLength: Int = 0
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    
    public var body: some View {
        VStack(spacing: 0){
            HStack {
                ZStack {
                    Text("\(placeholder)")
                        .foregroundColor(color.opacity(0))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                    
                    Text("\(placeholder)")
                        .offset(y: isFilled ? 0 : 10)
                        .foregroundColor(isFocused ? color : .gray)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .opacity(isFilled ? 1 : 0)
                    
                }
                Spacer()
            }
            HStack {
                if(systemIcon != "") {
                    Image(systemName: systemIcon)
                        .foregroundColor(isFocused ? color : .gray)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 30, height: 30)
                }
                ZStack {
                    TextField(placeholder, text: $secureContent, onEditingChanged: {_ in
                        withAnimation() {
                            isFocused.toggle()
                        }
                    }).accentColor(color)
                        .onChange(of: secureContent.count) { (change) in
                            checkValidation()
                            replaceSecureText()
                            if(secureContent == "") {
                                
                                withAnimation() {
                                    isFilled = false
                                }
                            } else {
                                
                                withAnimation() {
                                    isFilled = true
                                }
                            }
                            
                        }
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                    if(isFilled) {
                        HStack {
                            Spacer()
                            Button(action: {
                                clear()
                            }) {
                                Image(systemName: "xmark").foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            Rectangle().trim(from: 0, to: 0.5).foregroundColor(.gray).border(isFocused ? color : .gray, width: 2)
                .frame(height: 2).cornerRadius(1).padding(.top, 5)
        }
    }
    func clear() {
        self.content = ""
        self.secureContent = ""
    }
    
    func replaceSecureText() {
        if (secureContent.count <= currentTextLength) {
            if(content != "") {
                self.content.removeLast()
            }
        }
        else {
            if(secureContent != "") {
                let newChar = secureContent.last!
                self.content += String(newChar)
                if(secureContent.count >= 2) {
                    self.secureContent = String(repeating: "•", count: secureContent.count - 1) + String(newChar)
                }
            }
        }
        currentTextLength = secureContent.count
    }
    func checkValidation() {
        switch contentType {
        case .email: self.isValid = true
        case .name: self.isValid = true
        case .none : self.isValid = true
        case .number: self.isValid = true
        case .phone: self.isValid = true
        }
    }
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String, color: Color, icon: String, showClearButton: Bool) {
        self._content = content
        self._contentType = .init(initialValue: contentType)
        self._placeholder = .init(initialValue: placeholder)
        self._color = .init(initialValue: color)
        self._systemIcon = .init(initialValue: icon)
        self._showClearButton = .init(initialValue: showClearButton)
    }
    
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String, color: Color, icon: String) {
        self._content = content
        self._contentType = .init(initialValue: contentType)
        self._placeholder = .init(initialValue: placeholder)
        self._color = .init(initialValue: color)
        self._systemIcon = .init(initialValue: icon)
    }
    
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String, color: Color) {
        self._content = content
        self._contentType = .init(initialValue: contentType)
        self._placeholder = .init(initialValue: placeholder)
        self._color = .init(initialValue: color)
    }
    
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String) {
        self._content = content
        self._contentType = .init(initialValue: contentType)
        self._placeholder = .init(initialValue: placeholder)
    }
    
    public init(_ content: Binding<String>, placeholder: String) {
        self._content = content
        self._placeholder = .init(initialValue: placeholder)
    }
}

public extension FloatingSecureField {
    func contentType(_ contentType: ContentType) -> FloatingSecureField{
        FloatingSecureField(self.$content,
                            contentType: contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton)
    }
    func accentColor(_ color: Color) -> FloatingSecureField{
        FloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton)
    }
    func icon(systemName icon: String) -> FloatingSecureField {
        FloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: icon,
                            showClearButton: self.showClearButton)
    }
    func showClearButton(_ show: Bool) -> FloatingSecureField{
        FloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: show)
    }
}
