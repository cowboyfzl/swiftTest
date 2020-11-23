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
    case greaterThan
    case lessThan
}

class BinarySearchTree <E : Comparable> : BinarySearchTreeInterface {
    
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
            guard let root = self.root else {
                self.root = Node(element: element, parent: nil)
                _size += 1;
                return
            }
            
            var node:Node? = root;
            while node != nil {
                guard let nodeElement = node?.element else { return }
                let compareVale = compare(e1: nodeElement, e2: element)
                switch compareVale {
                case .equal:
                    node?.element = element
                case .greaterThan:
                    if node?.right != nil {
                        node = node?.right;
                    } else {
                        node?.right = Node(element: element, parent: node)
                        break
                    }
                case .lessThan:
                    if node?.left != nil {
                        node = node?.left;
                    } else {
                        node?.left = Node(element: element, parent: node)
                        break
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
            return NodeCompare.greaterThan
        }
        
        return NodeCompare.lessThan
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
}
