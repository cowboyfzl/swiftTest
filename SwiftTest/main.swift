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

// Now you initialize 'EmptyClass' with a closure that sets
// whatever variable properties you want to override:

EmptyClass { ec in
    ec.someFunc = { print("It worked!") }
    return ec
}.someFunc()
var aa = Person(a: 1)
var bb = Person(a: 2)
//workingClass.someFunc() // Outputs: "It worked!"

var tree = BinarySearchTree<Int>()
tree.add(elements: [5, 1, 6, 7, 8, 9, 200, 100])
BinaryTrees.println(tree: tree)



