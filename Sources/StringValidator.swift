//
//  StringValidator.swift
//  Pods
//
//  Created by Keegan Rush on 2016/12/22.
//
//

import Foundation

struct StringValidator {

    static func isUpperCaseOrNumber(_ value: String) -> Bool {
        return validate(value, regex: "[\\*,\\/\\-0-9A-Z]+")
    }

    static func isNumber(_ value: String) -> Bool {
        return validate(value, regex: "[\\*,\\/\\-0-9]+")
    }

    static func isAlphanumeric(_ value: String) -> Bool {
        return validate(value, regex: "[\\*,\\/\\-\\?LW0-9A-Za-z]+")
    }

    private static func validate(_ value: String, regex: String) -> Bool {
        #if os(Linux)
            typealias Regex = RegularExpression
        #else
            typealias Regex = NSRegularExpression
        #endif

        let regex = try! Regex(pattern: regex, options: [])
        return regex.numberOfMatches(in: value, options: [], range: NSMakeRange(0, value.characters.count)) > 0
    }
}
