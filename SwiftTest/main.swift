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

class EmptyClass {

    var someFunc:() ->() = { }

    init(overrides: (EmptyClass) -> EmptyClass) {
       _ = overrides(self)
    }
}

var aa = Person(a: 1)
var bb = Person(a: 2)
var cc = Person(a: 3)
var dd = Person(a: 5)
var ee = Person(a: 4)

var tree = BinarySearchTree<Int>()
tree.add(elements: [7, 4, 9, 2, 5, 8, 11, 12, 1])
BinaryTrees.println(tree: tree)
tree.inorderTraversal(order: NodeOrder.Ascending)


