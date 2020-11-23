//
//  BinaryTreeInfo.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

protocol BinaryTreeInfo {
    func root() -> AnyObject?
    func left(node:AnyObject?) -> AnyObject?
    func right(node:AnyObject?) -> AnyObject?
    func string(node:AnyObject?) -> AnyObject?
}
