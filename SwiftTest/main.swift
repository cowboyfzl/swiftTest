//
//  main.swift
//  SwiftTest
//
//  Created by mac on 2020/4/1.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

struct Person : Comparable {
    var a = 0
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.a < rhs.a
    }
}

class EmptyClass : Visitor {
    
    func vistor(e: Any) {
        var e = e as? Int
        e! += 1;
    }
}

var aa = Person(a: 1)
var bb = Person(a: 2)
var cc = Person(a: 3)
var dd = Person(a: 5)
var ee = Person(a: 4)

var tree = BinarySearchTree<Int>()
tree.add(elements: [7, 4, 9, 2, 5, 8, 11, 13, 1, 12])
BinaryTrees.println(tree: tree)
var index = 0
var p = tree.preorderTraversalOrder { value, stop in
    if index == 5 {
        stop = true
    }
    index += 1;
    return value
    
}

print(p ?? "没有数据")
