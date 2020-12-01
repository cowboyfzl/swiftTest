//
//  BSTree.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/20.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

protocol  BinarySearchTreeInterface {
    associatedtype E : Comparable
    func size() -> Int
    func isEmpty() -> Bool;
    func add(elements:[E])
    func remove(element: E)
    func contains(element: E)
    
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
    
    
    
    /// 前序 （根、左、右）
    func preorderTraversal() {
        preorderTraversal(node: root ?? nil)
    }
    
    private func preorderTraversal(node:Node?) {
        if node == nil {
            return
        }
        
        print(node?.element ?? " ")
        preorderTraversal(node: node?.left)
        preorderTraversal(node: node?.right)
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
    
    /// 层序遍历（从上往下，从左往右依次访问）
    func levelOrderTraversal() {
        var list = Array<E>()
        
    }
    
    private func levelOrderTraversal(node:Node?) {
        
    }
}
