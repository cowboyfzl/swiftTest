//
//  Printer.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

class Printer {
    var tree:BinaryTreeInfo;
    init(tree:BinaryTreeInfo) {
        self.tree = tree
    }
    
    func printString() -> String {
        return ""
    }
    
    func println() {
        print()
        Swift.print()
    }
    
    func print() {
        Swift.print(printString(), separator: "", terminator: "")
    }
}
