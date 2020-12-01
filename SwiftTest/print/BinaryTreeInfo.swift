//
//  BinaryTreeInfo.swift
//  SwiftTest
//
//  Created by XCDev on 2020/11/23.
//  Copyright © 2020 xinchao. All rights reserved.
//

import Foundation

protocol BinaryTreeInfo {
    
    /// 获取根节点
    func getRoot() -> AnyObject?
    
    /// 左子节点
    /// - Parameter node: 节点
    func left(node:AnyObject?) -> AnyObject?
    
    /// 又子节点
    /// - Parameter node: 节点
    func right(node:AnyObject?) -> AnyObject?
    
    /// 节点内容
    /// - Parameter node: 节点
    func string(node:AnyObject?) -> String?
}
