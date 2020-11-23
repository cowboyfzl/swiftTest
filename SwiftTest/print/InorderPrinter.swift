//
//  InorderPrinter.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation
/**

             ┌──800
         ┌──760
         │   └──600
     ┌──540
     │   └──476
     │       └──445
 ┌──410
 │   └──394
381
 │     ┌──190
 │     │   └──146
 │  ┌──40
 │  │  └──35
 └──12
    └──9
 
 *
 */
private let length = 2
class InorderPrinter : Printer {
    var tree: BinaryTreeInfo
    private static var rightAppend = "┌" + Strings.repeatString(string: "-", count: length)
    private static var leftAppend = "└" + Strings.repeatString(string: "-", count: length)
    private static var blankAppend = Strings.blank(length: length + 1)
    private static var lineAppend = "|" + Strings.blank(length: length)
    
    required init(tree: BinaryTreeInfo) {
        self.tree = tree
    }
    
    func printString() -> String {
        var string = printStrings(node: tree.root(), nodePrefix: "", leftPrefix: "", rightPrefix: "")
        string.removeLast(1)
        return string
    }
    
    private func printStrings(node:AnyObject?, nodePrefix: String, leftPrefix: String, rightPrefix: String) -> String {
        let left = tree.left(node: node)
        let right = tree.right(node: node)
        let string = tree.string(node: node) as? String
        var length = string?.count ?? 0
        if length % 2 == 0 {
            length -= 1
        }
        
        length >>= 1
        
        var nodeString = ""
        var rightPrefix = rightPrefix
        if right != nil {
            rightPrefix += Strings.blank(length: length)
            nodeString += printStrings(node: right, nodePrefix: rightPrefix + InorderPrinter.rightAppend, leftPrefix: rightPrefix + InorderPrinter.lineAppend, rightPrefix: rightPrefix + InorderPrinter.blankAppend)
        }
        
        nodeString += nodePrefix + (string ?? "") + "\n"
        var leftPrefix = leftPrefix
        if left != nil {
            leftPrefix += Strings.blank(length: length)
            nodeString += printStrings(node: left, nodePrefix: leftPrefix + InorderPrinter.leftAppend, leftPrefix: leftPrefix + InorderPrinter.blankAppend, rightPrefix: leftPrefix + InorderPrinter.lineAppend)
        }
        return nodeString
    }
    
}
