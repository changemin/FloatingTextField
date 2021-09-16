//
//  FloatingTextFieldView.swift
//
//
//  Created by 변경민 on 2020/12/21.
//
import SwiftUI

public struct FloatingTextField: View {
    @Binding public var content: String
    @State public var contentType: ContentType = .none
    @State public var placeholder: String = "Placeholder"
    @State public var color: Color = Color(.sRGB, red: 50/255, green: 200/255, blue: 165/255)
    @State public var systemIcon: String = ""
    @State public var showClearButton: Bool = true
    @State public var style: FloatingTextFieldStyle = .normal
    @State public var fontSize: CGFloat = 15
    @State public var fontWeight: Font.Weight = .regular
    @State var isFocused: Bool = false
    @State var isFilled: Bool = false
    @State var isValid: Bool = true
    
    public var body: some View {
        ZStack {
            if(style == .square) {
                HStack {
                    ZStack {
                        Text("\(placeholder)")
                            .offset(x: 15, y: isFilled ? -20 : -10)
                            .foregroundColor(isFocused ? color : .gray)
                            .font(.system(size: fontSize, weight: fontWeight, design: .rounded))
                            .opacity(isFilled ? 1 : 0)
                    }
                    Spacer()
                }
            }
            VStack(spacing: 0){
                if(style == .normal) {
                    HStack {
                        ZStack {
                            Text("\(placeholder)")
                                .foregroundColor(color.opacity(0))
                                .font(.system(size: fontSize, weight: fontWeight, design: .rounded))
                            
                            Text("\(placeholder)")
                                .offset(y: isFilled ? 0 : 10)
                                .foregroundColor(isFocused ? color : .gray)
                                .font(.system(size: fontSize, weight: fontWeight, design: .rounded))
                                .opacity(isFilled ? 1 : 0)
                        }
                        Spacer()
                    }
                }
                else if(style == .square) {
                    Text("\(placeholder)")
                        .foregroundColor(color.opacity(0))
                        .font(.system(size: 5, weight: .medium, design: .rounded))
                }
                HStack {
                    if(systemIcon != "") {
                        Image(systemName: systemIcon)
                            .foregroundColor(isFocused ? color : .gray)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .frame(width: 30, height: 30)
                    }
                    ZStack {
                        TextField(placeholder, text: $content, onCommit: {
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
                                    Image(systemName: "xmark").foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    }
                }
                if(style == .normal) {
                    Rectangle().frame(height: 2).cornerRadius(2).padding(.top, 5).foregroundColor(isFocused ? color : .gray)
                }
                else if(style == .square){
                    Rectangle().frame(height: 2).cornerRadius(2).padding(.top, 5).foregroundColor(.clear)
                }
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(isFocused ? color : Color.gray, lineWidth: style == .square ? 0.75 : 0)
            
        )
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
    public init(_ content: Binding<String>, contentType: ContentType, placeholder: String, color: Color, icon: String, showClearButton: Bool, style: FloatingTextFieldStyle) {
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
    
    public init(_ content: Binding<String>, placeholder: String, fontSize: CGFloat, fontWeight: Font.Weight) {
        self._content = content
        self._placeholder = .init(initialValue: placeholder)
        self._fontSize = .init(initialValue: fontSize)
        self._fontWeight = .init(initialValue: fontWeight)
    }
}

public extension FloatingTextField {
    func contentType(_ contentType: ContentType) -> FloatingTextField{
        FloatingTextField(self.$content,
                            contentType: contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func accentColor(_ color: Color) -> FloatingTextField{
        FloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: color,
                            icon: self.systemIcon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func icon(systemName icon : String) -> FloatingTextField {
        FloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: icon,
                            showClearButton: self.showClearButton,
                            style: self.style)
    }
    func showClearButton(_ show: Bool) -> FloatingTextField{
        FloatingTextField(self.$content,
                            contentType: self.contentType,
                            placeholder: self.placeholder,
                            color: self.color,
                            icon: self.systemIcon,
                            showClearButton: show,
                            style: self.style)
    }
    func styled(_ style: FloatingTextFieldStyle) -> FloatingTextField{
        FloatingTextField(self.$content,
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
