//
//  Strings.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation
class Strings {
    static func repeatString(string: String, count:Int) -> String {
        if (string.count == 0) {
            return ""
        }
        
        var aCount = count;
        var aString = ""
        while aCount > 0 {
            aString.append(string)
            aCount -= 1
        }
        
        return aString
    }
    
    static func blank(length: Int) -> String {
        if length <= 0 {
            return ""
        }
        
        return String(repeating: " ", count: length)
    }
}
