//
//  BSTree.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/20.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

protocol BinarySearchTreeInterface {
    associatedtype E : Comparable
    func size() -> Int
    func isEmpty() -> Bool;
    func add(elements:[E])
    func remove(element: E)
    func contains(element: E)
    
}

protocol Visitor {
    func vistor(e:Any)
}

enum NodeCompare : Int {
    case equal = 0
    case right
    case left
}

enum NodeOrder {
    /// 升序
    case Ascending
    /// 降序
    case Descending
}

class BinarySearchTree <E : Comparable> : BinarySearchTreeInterface, BinaryTreeInfo {
    func getRoot() -> AnyObject? {
        return root
    }
    
    func left(node: AnyObject?) -> AnyObject? {
        let node = node as? Node;
        return node?.left
    }
    
    func right(node: AnyObject?) -> AnyObject? {
        let node = node as? Node;
        return node?.right
    }
    
    func string(node: AnyObject?) -> String? {
        let node = node as? Node;
        if let node = node {
            return "\(node.element!)"
        }
        
        return ""
    }
    
    private var _size:Int = 0;
    private var root:Node?
    
    func size() -> Int {
        return _size;
    }
    
    func isEmpty() -> Bool {
        return _size == 0
    }
    
    func add(elements:[E]) {
        for element in elements {
            if root == nil {
                self.root = Node(element: element, parent: nil)
                _size += 1;
                continue
            }
            
            var node:Node? = root;
            while node != nil {
                guard let nodeElement = node?.element else { return }
                let compareVale = compare(e1: nodeElement, e2: element)
                switch compareVale {
                case .equal:
                    node?.element = element
                    node = nil
                case .right:
                    if node?.right != nil {
                        node = node?.right;
                    } else {
                        node?.right = Node(element: element, parent: node)
                        node = nil
                    }
                case .left:
                    if node?.left != nil {
                        node = node?.left;
                    } else {
                        node?.left = Node(element: element, parent: node)
                        node = nil
                    }
                }
            }
            
            _size += 1;
        }
    }
    
    //    private func elementNotNullCheck(element: E?) throws -> Bool {
    //        if element == nil {
    //            throw NodeError.nodeNull
    //        }
    //
    //        return true
    //    }
    
    /// 比较
    /// - Parameters:
    ///   - e1: 参数1
    ///   - e2: 参数2
    /// - Returns: 相等为0;e1 > e2 大于0; e1 < e2 小于0
    private func compare(e1:E, e2:E) -> NodeCompare {
        if e1 == e2 {
            return NodeCompare.equal
        }
        
        if e1 > e2 {
            return NodeCompare.left
        }
        
        return NodeCompare.right
    }
    
    func remove(element: E) {
        
    }
    
    func contains(element: E) {
        
    }
    
    private class Node {
        var element:E?
        var left:Node?
        var right:Node?
        var parent:Node?
        init(element:E, parent:Node?) {
            self.element = element
            self.parent = parent;
        }
    }
    
    func levelOrder() -> [E] {
         levelOrder {$0}
    }
    
    func levelOrder(_ visitor: (E) -> E) -> [E] {
        var list = Array<Node>()
        var nodes = Array<Node>()
        if let node = root {
            list.append(node)
        }
        
        while !list.isEmpty {
            let firstNode = list.removeFirst()
            firstNode.element = visitor(firstNode.element!)
            if let left = firstNode.left {
                list.append(left)
            }
            
            if let right = firstNode.right {
                list.append(right)
            }
            
            nodes.append(firstNode)
        }
        
        return nodes.map { (node) -> E in
            node.element!
        }
    }
    
    /// 前序 （根、左、右）
    func preorderTraversalOrder(_ visitor: (E, inout Bool) -> E) -> [E]? {
       return preorderTraversal(visitor, node: root)
    }
    
    private func preorderTraversal(_ visitor: (E, inout Bool) -> E, node:Node?) -> [E]? {
        if node == nil {
            return nil
        }
        
        guard let node = node else { return nil}
        var tempNodes = [Node]()
        var tempNode:Node? = node
        var results = [E]()
        var stop = false;
        while !tempNodes.isEmpty || tempNode != nil {
            while tempNode != nil {
                let changeElement = visitor(tempNode!.element!, &stop)
                if stop {
                    break
                }
                
                tempNode?.element = changeElement;
                results.append(changeElement)
                tempNodes.append(tempNode!)
                tempNode = tempNode?.left
            }
            
            tempNode = tempNodes.popLast()
            tempNode = tempNode?.right
        }
        
        return results
    }
    
    func per() {
        per(node:root)
    }
    
    private func per(node:Node?) {
        if node == nil {
            return
        }
        
        print(node?.element ?? "")
        per(node: node?.left)
        per(node: node?.right)
    }
    
    
    /// 中序遍历 （左、根、右）升序或者降序
    func inorderTraversal(order:NodeOrder) {
        switch order {
        case .Ascending:
            inorderTraversalAscending(node: root)
        default:
            inorderTraversalDescending(node: root)
        }
    }
    
    private func inorderTraversalAscending(node:Node?) {
        if node == nil {
            return
        }
        
        inorderTraversalAscending(node: node?.left)
        print(node?.element ?? " ")
        inorderTraversalAscending(node: node?.right)
    }
    
    private func inorderTraversalDescending(node:Node?) {
        if node == nil {
            return
        }
        
        inorderTraversalDescending(node: node?.right)
        print(node?.element ?? " ")
        inorderTraversalDescending(node: node?.left)
    }
    
    /// 后续遍历 (左、右、根)
    func postorderTraversal() {
        postorderTraversal(node: root)
    }
    
    private func postorderTraversal(node:Node?) {
        if node == nil {
            return
        }
        
        postorderTraversal(node: node?.left)
        postorderTraversal(node: node?.right)
        print(node?.element ?? " ")
    }
}
