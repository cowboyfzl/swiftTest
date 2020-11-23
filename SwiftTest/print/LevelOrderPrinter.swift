//
//  LevelOrderPrinter.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation
/**

   ┌───381────┐
   │          │
┌─12─┐     ┌─410─┐
│    │     │     │
9  ┌─40─┐ 394 ┌─540─┐
   │    │     │     │
  35 ┌─190 ┌─476 ┌─760─┐
     │     │     │     │
    146   445   600   800
    
 *
 */
class LevelOrderPrinter: Printer {
    var tree: BinaryTreeInfo
    private static let MIN_SPACE = 1
    private var root:Node?
    required init(tree: BinaryTreeInfo) {
        self.tree = tree
    }
    
    private class Node : Equatable {
        static func == (lhs: LevelOrderPrinter.Node, rhs: LevelOrderPrinter.Node) -> Bool {
            lhs == rhs
        }
        
        
        /// 顶部符号距离父节点的最小距离（最小能填0）
        private static let TOP_LINE_SPACE = 1
        var btNode:AnyObject?
        var left:Node?
        var right:Node?
        var parent:Node?
        
        var x = 0
        var y = 0
        var treeHeight = 0
        var string = ""
        var width = 0
        
        private init(string: String?) {
            var string = string
            string = string ?? "nil"
            string = string!.isEmpty ? " " : string
            width = string?.count ?? 0
        }
        
        convenience init(str:String?) {
            self.init(string: str)
        }
        
        convenience init(btNode:AnyObject, opetaion:BinaryTreeInfo) {
            self.init(string: opetaion.string(node: btNode) as? String)
            self.btNode = btNode
        }
        
        private func topLineX() -> Int {
            var delta = width
            if delta % 2 == 0 {
                delta -= 1
            }
            
            delta >>= 1
            
            if parent != nil && self == parent?.left {
                return rightX() - 1 - delta
            }
            
            return x + delta
        }
        
        private func rightBound() -> Int {
            if right == nil {
                return rightX()
            }
            
            return right?.topLineX() ?? 0 + 1
        }
        
        private func leftBound() -> Int {
            if left == nil {
                return x
            }
            
            return left?.topLineX() ?? 0
        }
        
        private func leftBoundLength() -> Int {
            x - leftBound()
        }
        
        private func leftBoundEmptyLength() -> Int {
            leftBoundLength() - 1 - LevelOrderPrinter.Node.TOP_LINE_SPACE
        }
        
        func rightX() -> Int {
            return x + width
        }
    }
    
    func printString() -> String {
        ""
    }
    
}
