//
//  CMFloatingTextFieldView.swift
//
//
//  Created by 변경민 on 2020/12/21.
//

import SwiftUI

public struct CMFloatingTextField: View {
    @Binding public var content: String
    @State public var contentType: ContentType = .none
    @State public var placeholder: String = "Placeholder"
    @State public var color: Color = .blue
    @State public var systemIcon: String = ""
    @State public var showClearButton: Bool = true
    @State public var style: CMFloatingTextFieldStyle = .normal
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    
    public var body: some View {
        ZStack {
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
                        TextField(placeholder, text: $content, onEditingChanged: {_ in
                            withAnimation() {
                                isFocused.toggle()
                            }
                        })
                        .adaptiveKeyboardType(type: contentType)
                        .accentColor(color)
                            .onChange(of: content) { _ in
                                checkValidation()
                                
                                if(content == "") {
                                    withAnimation(.spring()) {
                                        isFilled = false
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        isFilled = true
                                    }
                                }
                            }
                        
                        if(isFilled) {
                            HStack {
                                Spacer()
                                Button(action: {
                                    clear()
                                }) {
                                    Image(systemName: "xmark.circle").foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                Rectangle().frame(height: 2).cornerRadius(2).padding(.top, 5).foregroundColor(isFocused ? color : .gray)
            }
        }
    }
    func clear() {
        self.content = ""
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
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String, color: Color, icon: String, showClearButton: Bool, style: CMFloatingTextFieldStyle) {
        self._content = content
        self._contentType = .init(initialValue: contentType)
        self._placeholder = .init(initialValue: placeholder)
        self._color = .init(initialValue: color)
        self._systemIcon = .init(initialValue: icon)
        self._showClearButton = .init(initialValue: showClearButton)
        self._style = .init(initialValue: style)
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

public extension CMFloatingTextField {
    func contentType(_ contentType: ContentType) -> CMFloatingTextField{
        CMFloatingTextField(self.$content,
                            contentType: contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func accentColor(_ color: Color) -> CMFloatingTextField{
        CMFloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func icon(systemName icon : String) -> CMFloatingTextField {
        CMFloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: icon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func showClearButton(_ show: Bool) -> CMFloatingTextField{
        CMFloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: show,
                            style: self.style)
    }
    func styled(_ style: CMFloatingTextFieldStyle) -> CMFloatingTextField{
        CMFloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton,
                            style: style)
    }
}

extension TextField {
    func adaptiveKeyboardType(type contentType: ContentType) -> some View {
        self.modifier(AdaptiveKeyboardTypeModifier(contentType: contentType))
    }
}

struct AdaptiveKeyboardTypeModifier: ViewModifier {
    @State var contentType: ContentType
    init(contentType: ContentType) {
        self._contentType = .init(initialValue: contentType)
    }
    func body(content: Content) -> some View {
        var keyboardType: UIKeyboardType = .default
        switch contentType {
        case .email: keyboardType = .emailAddress
        case .name: keyboardType = .namePhonePad
        case .none: keyboardType = .default
        case .number: keyboardType = .numberPad
        case .phone: keyboardType = .numberPad
        }
        return content.keyboardType(keyboardType)
    }
}
