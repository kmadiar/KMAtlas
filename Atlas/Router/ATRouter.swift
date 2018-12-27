//
//  ATRouter.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

protocol ATRouter: ATPresentable {
    
    func push(_ module: ATPresentable?)
    func push(_ module: ATPresentable?, animated: Bool)
    func push(_ module: ATPresentable?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func setRootModule(_ module: ATPresentable?)
    func setRootModule(_ module: ATPresentable?, hideBar: Bool)
    
    func removeFromStack(_ module: ATPresentable?)
    func insert(module: ATPresentable?, before: ATPresentable?)
}
