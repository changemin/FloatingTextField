//
//  Model.swift
//  CMFloatingTextField
//
//  Created by 변경민 on 2020/12/21.
//

import Foundation

public enum ContentType {
    case none
    case password
    case email
    case number
    case phone
    case name
}

public func checkValidation(_ content: String, type: ContentType) -> Bool{
    switch type {
    case .email: return true
    case .name: return true
    case .none: return true
    case .number: return true
    case .password: return true
    case .phone: return true
    }
}

