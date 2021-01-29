//
//  Model.swift
//  FloatingTextField
//
//  Created by 변경민 on 2020/12/21.
//

import Foundation

public enum ContentType {
    case none
    case email
    case number
    case phone
    case name
}

public enum FloatingTextFieldStyle {
    case normal
    case square
}

public func checkValidation(_ content: String, type: ContentType) -> Bool{
    switch type {
    case .email: return true
    case .name: return true
    case .none: return true
    case .number: return true
    case .phone: return true
    }
}

public struct Restricts {
    var minLength: Int = Int.min
    var maxLegnth: Int = Int.max
    
    public init() {
        
    }
}
