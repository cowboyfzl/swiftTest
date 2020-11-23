//
//  LevelOrderPrinter.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

class LevelOrderPrinter: Printer {
    var tree: BinaryTreeInfo
    required init(tree: BinaryTreeInfo) {
        self.tree = tree
    }
    
    func printString() -> String {
        ""
    }
    
}
