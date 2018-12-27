//
//  ATRouter.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation

protocol ATRouter: ATPresentable {
    
    func present(_ module: ATPresentable?)
    func present(_ module: ATPresentable?, animated: Bool)
    
    func push(_ module: ATPresentable?)
    func push(_ module: ATPresentable?, animated: Bool)
    func push(_ module: ATPresentable?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: ATPresentable?)
    func setRootModule(_ module: ATPresentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
    
    func removeFromStack(_ module: ATPresentable?)
    func insert(module: ATPresentable?, before: ATPresentable?)
}
