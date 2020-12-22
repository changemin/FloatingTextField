//
//  CMFloatingTextSecureField.swift
//
//
//  Created by 변경민 on 2020/12/22.
//

import SwiftUI

public struct CMFloatingSecureField: View {
    @Binding public var content: String
    @State public var contentType: ContentType = .none
    @State public var placeholder: String = "Placeholder"
    @State public var color: Color = .purple
    @State public var systemIcon: String = ""
    @State public var showClearButton: Bool = true
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
                    if(isFilled) {
                        Text("\(placeholder)")
                            .foregroundColor(isFocused ? color : .gray)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                    }
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
                    HStack {
                        Text("\(String(repeating: "•", count: content.count))")
                        Spacer()
                    }
                    
                    TextField(placeholder, text: $content, onEditingChanged: {_ in
                        withAnimation() {
                            isFocused.toggle()
                        }
                    }).accentColor(color)
                        .onChange(of: content) { _ in
                            checkValidation()
                            if(content == "") {
                                withAnimation() {
                                    isFilled = false
                                }
                            } else {
                                withAnimation() {
                                    isFilled = true
                                }
                            }
                        }
                    .foregroundColor(.clear)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
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
            Rectangle().trim(from: 0, to: 0.5).foregroundColor(.gray).border(isFocused ? color : .gray, width: 2)
                .frame(height: 2).cornerRadius(1).padding(.top, 5)
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

public extension CMFloatingSecureField {
    func contentType(_ contentType: ContentType) -> CMFloatingSecureField{
        CMFloatingSecureField(self.$content,
                            contentType: contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton)
    }
    func accentColor(_ color: Color) -> CMFloatingSecureField{
        CMFloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton)
    }
    func icon(systemName icon: String) -> CMFloatingSecureField {
        CMFloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: icon,
                            showClearButton: self.showClearButton)
    }
    func showClearButton(_ show: Bool) -> CMFloatingSecureField{
        CMFloatingSecureField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: show)
    }
}