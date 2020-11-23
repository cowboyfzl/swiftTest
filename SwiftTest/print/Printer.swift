//
//  Printer.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

protocol Printer {
    var tree:BinaryTreeInfo { get set};
    init(tree:BinaryTreeInfo)
    
    /// 抽象方法需要重写
    func printString() -> String
    
    func println()
    
    func print()
}

extension Printer {
    init(tree:BinaryTreeInfo) {
        self.init(tree: tree)
        self.tree = tree
    }
    
    func println() {
        print()
        Swift.print()
    }
    
    func print() {
        Swift.print(printString(), separator: "", terminator: "")
    }

}
