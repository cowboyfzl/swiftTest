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
class LevelOrderPrinter : Printer {
    var tree: BinaryTreeInfo
    private static let MIN_SPACE = 1
    private var root:Node?
    private var minX = 0
    private var maxWidth = 0
    required init(tree: BinaryTreeInfo) {
        self.tree = tree
    }
    
    private class Node : Equatable {
        
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
        
        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs == rhs
        }
        
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
            if let parentLeft = parent?.left {
                if parent != nil && self == parentLeft {
                    return rightX() - 1 - delta
                }
            }
            
            return x + delta
        }
        
        fileprivate func rightBound() -> Int {
            if right == nil {
                return rightX()
            }
            
            return right?.topLineX() ?? 0 + 1
        }
        
        fileprivate func leftBound() -> Int {
            if left == nil {
                return x
            }
            
            return left?.topLineX() ?? 0
        }
        
        fileprivate func leftBoundLength() -> Int {
            x - leftBound()
        }
        
        fileprivate func leftBoundEmptyLength() -> Int {
            leftBoundLength() - 1 - LevelOrderPrinter.Node.TOP_LINE_SPACE
        }
        
        fileprivate func rightBoundLength() -> Int {
            return rightBound() - rightX()
        }
        
        fileprivate func rightBoundEmptyLength() -> Int {
            rightBoundLength() - 1 - LevelOrderPrinter.Node.TOP_LINE_SPACE
        }
        
        fileprivate func balance(left:Node?, right:Node?) {
            if let left = left, let right = right {
                // 【left的尾字符】与【this的首字符】之间的间距
                let deltaLeft = x - left.rightX()
                // 【this的尾字符】与【this的首字符】之间的间距
                let deltaRight = right.x - rightX()
                
                let delta = max(deltaLeft, deltaRight)
                let newRgihtX = rightX() + delta
                right.translateX(newRgihtX - right.x)
                
                let newLeftX = x - delta - left.width
                left.translateX(newLeftX - left.x)
            }
        }
        
        private func treeHeight(node:Node?) -> Int {
            guard let node = node else { return 0 }
            guard node.treeHeight == 0 else {return node.treeHeight}
            node.treeHeight = 1 + max(treeHeight(node: node.left), treeHeight(node: node.right))
            return node.treeHeight
        }
        
        private func minLevelSpaceTopRight(right: Node) -> Int {
            let thisHeight = treeHeight(node: self)
            let rightHeight = treeHeight(node: right)
            var minSpace  = Int.max
            
            var i = 0
            while i < thisHeight && i < rightHeight  {
                let space = right.levelInfo(level: i)!.leftX - self.levelInfo(level: i)!.rightX
                minSpace = min(minSpace, space)
                i += 1
            }
            
            return minSpace
            
        }
        
        fileprivate func minLevelSpaceToRight(right:Node) -> Int {
            let thisHeight = treeHeight(node: self)
            let rightHeight = treeHeight(node: right)
            var miniSpace = Int.max
            
            var i = 0
            while i < thisHeight && i < rightHeight {
                let space = right.levelInfo(level: i)?.leftX ?? 0 - (self.levelInfo(level: i)?.rightX ?? 0)
                miniSpace = min(miniSpace, space)
                i += 1
            }
            
            return miniSpace
        }
        
        private func levelInfo(level:Int) -> LevelInfo? {
            guard level >= 0 else { return nil }
            let levelY = y + level
            if level > treeHeight(node: self) { return nil }
            
            var list = Array<Node>()
            var queue = Array<Node>()
            queue.append(self);
            
            while !queue.isEmpty {
                let node = queue.popLast()
                if let node = node {
                    if levelY == node.y {
                        list.append(node)
                    } else if (node.y > levelY) {
                        break
                    }
                    
                    if node.left != nil {
                        queue.append(node.left!)
                    }
                    
                    if node.right != nil {
                        queue.append(node.right!)
                    }
                }
            }
            
            let left = list[0]
            let right = list[list.count - 1]
            return LevelInfo(left: left, right: right)
        }
        
        func translateX(_ deltaX:Int) {
            if deltaX == 0 {
                return
            }
            
            x += deltaX
            
            if btNode == nil {
                return
            }
            
            if left != nil {
                left?.translateX(deltaX)
            }
            
            if right != nil {
                right?.translateX(deltaX)
            }
        }
        
        func rightX() -> Int {
            return x + width
        }
        
        private class LevelInfo {
            var leftX = 0
            var rightX = 0
            
            init(left:Node?, right:Node?) {
                self.leftX = left?.leftBound() ?? 0
                self.rightX = right?.rightBound() ?? 0
            }
        }
    }
    
    private func addNode(nodes:inout [Node?], btNode:AnyObject?) -> Node? {
        var node:Node?
        if let btNode = btNode {
            node = Node(btNode: btNode, opetaion: tree)
            self.maxWidth = max(maxWidth, node?.width ?? 0)
            nodes.append(node)
        } else {
            nodes.append(node)
        }
        
        return node
    }
    
    private func fillNodes(nodes: inout[[Node?]]) {
        var firstRowNodes = [Node]()
        guard let root = self.root else { return }
        firstRowNodes.append(root)
        nodes.append(firstRowNodes)
        
        while true {
            let preRowNodes = nodes[nodes.count - 1]
            var rowNodes = [Node?]()
            var notNull = false
            for node in preRowNodes {
                //TOOD看情况再处理
                if node == nil {
                    rowNodes.append(nil)
                    rowNodes.append(nil)
                } else {
                    let left = addNode(nodes: &rowNodes, btNode: tree.left(node: node?.btNode))
                    if let left = left {
                        node?.left = left
                        left.parent = node
                        notNull = true
                    }
                    
                    let right = addNode(nodes: &rowNodes,btNode: tree.right(node: node?.btNode))
                    
                    if let right = right {
                        node?.right = right
                        right.parent = node
                        notNull = true
                    }
                }
            }
            
            if !notNull { break }
            nodes.append(rowNodes)
        }
    }
    
    private func cleanNodes(nodes: inout[[Node?]]) {
        let rowCount = nodes.count
        if rowCount < 2 { return }
        
        // 最后一行的节点数量
        let lastRowNodeCount = nodes[rowCount - 1].count
        
        // 每个节点之间的间距
        let nodeSpace = maxWidth + 2
        
        // 最后一行的长度
        let lastRowLength = lastRowNodeCount * maxWidth + nodeSpace * (lastRowNodeCount - 1)
        
        // 空集合
        
        for i in 0..<rowCount {
            var rowNodes = nodes[i]
            let rowNodeCount = rowNodes.count
            // 节点左右两边间距
            let allSpace = lastRowLength - (rowNodeCount - 1) * nodeSpace
            var cornerSpace = allSpace / rowNodeCount - maxWidth
            cornerSpace >>= 1
            
            var rowLength = 0
            for j in 0..<rowNodeCount {
                if j != 0 {
                    // 每个节点之间的间距
                    rowLength += nodeSpace
                }
                
                rowLength += cornerSpace
                
                let node = rowNodes[j]
                if let node = node {
                    // 居中（由于奇偶数的问题，可能有1个符号的误差）
                    let deltaX = (maxWidth - node.width) >> 1
                    node.x = rowLength + deltaX
                    node.y = i
                }
                
                rowLength += maxWidth
                rowLength += cornerSpace
            }
            
            rowNodes = rowNodes.filter {$0 != nil}
        }
    }
    
    private func compressNodes(nodes: inout[[Node?]]) {
        let rowCount = nodes.count
        if rowCount < 2 { return }
        
        for i in 0..<rowCount {
            let rowNodes = nodes[i]
            for node in rowNodes {
                let left = node?.left
                let right = node?.right
                
                if let left = left, let right = right {
                    // 让左右节点对称
                    node?.balance(left: left, right: right)
                    
                    // left和right之间可以挪动的最小间距
                    var leftEmpty = node?.leftBoundEmptyLength()
                    var rightEmpty = node?.rightBoundEmptyLength()
                    var empty = min(leftEmpty ?? 0, rightEmpty ?? 0)
                    empty = min(empty, (right.x - left.rightX()) >> 1 )
                    
                    // left、right的子节点之间可以挪动的最小间距
                    var space = left.minLevelSpaceToRight(right: right) - LevelOrderPrinter.MIN_SPACE
                    space = min(space >> 1, empty)
                    
                    if space > 0 {
                        left.translateX(space)
                        right.translateX(-space)
                    }
                    
                    // 继续挪动
                    space = left.minLevelSpaceToRight(right: right) - LevelOrderPrinter.MIN_SPACE
                    if space < 1 {
                        continue
                    }
                    
                    // 可以继续挪动的间距
                    leftEmpty = node?.leftBoundEmptyLength()
                    rightEmpty = node?.rightBoundEmptyLength()
                    guard let leftEmptya = leftEmpty, let rightEmptya = rightEmpty else { continue }
                    if leftEmptya < 1 && rightEmptya < 1 {
                        continue
                    }
                    
                    if leftEmptya > rightEmptya {
                        left.translateX(min(leftEmptya, space))
                    } else {
                        right.translateX(-min(rightEmptya, space))
                    }
                } else if (left != nil) {
                    left?.translateX(node?.leftBoundEmptyLength() ?? 0)
                } else { // right != null
                    right?.translateX(-(node?.rightBoundEmptyLength() ?? 0))
                }
            }
        }
    }
    
    func printString() -> String {
        var nodes = [[Node?]]()
        fillNodes(nodes: &nodes)
        cleanNodes(nodes: &nodes)
        compressNodes(nodes: &nodes)
    }
    
}
