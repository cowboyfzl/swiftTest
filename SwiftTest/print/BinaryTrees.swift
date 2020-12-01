//
//  BinaryTrees.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

class BinaryTrees {
    
    enum PrintStyle {
        case LEVEL_ORDER
        case INORDER
    }
    
    private init() {}
    
    static func print(tree: BinaryTreeInfo) {
        Swift.print(tree, separator: "", terminator: "")
    }
    
    static func println(tree: BinaryTreeInfo) {
        println(tree: tree, style: nil)
    }
    
    static func print(tree: BinaryTreeInfo, style:PrintStyle) {
        if tree.getRoot() == nil {return}
        printer(tree: tree, style: style)?.print()
    }
    
    static func println(tree: BinaryTreeInfo, style:PrintStyle?) {
        if tree.getRoot() == nil {return}
        printer(tree: tree, style: style)?.println()
    }
    
    static func printString(tree: BinaryTreeInfo) -> String? {
        printString(tree: tree, style: PrintStyle.LEVEL_ORDER)
    }
    
    static func printString(tree:BinaryTreeInfo, style:PrintStyle) -> String? {
        if tree.getRoot() == nil { return nil }
        return printer(tree: tree, style: style)?.printString()
    }
    
    static func printer(tree: BinaryTreeInfo, style:PrintStyle?) -> Printer? {
        if  style == PrintStyle.INORDER {
            return InorderPrinter(tree: tree)
        }
        
        return LevelOrderPrinter(tree: tree)
    }
    
}
