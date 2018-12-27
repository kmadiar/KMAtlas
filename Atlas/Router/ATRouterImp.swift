//
//  ATRouterImp.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class ATRouterImp: NSObject, ATRouter {
    func insert(module: ATPresentable?, before: ATPresentable?) {
        guard let controller = module?.toPresent()/*, let beforeController = before?.toPresent()*/ else { return }
        
        if let count = rootController?.viewControllers.count {
            let i = (count - 1) >= 0 ? count - 1 : 0
            rootController?.viewControllers.insert(controller, at: i)
        }
    }
    
    func removeFromStack(_ module: ATPresentable?) {
        guard let controller = module?.toPresent() else { return }
        if let index = rootController?.viewControllers.firstIndex(of: controller) {
            rootController?.viewControllers.remove(at: index)
        }
    }
    
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: ATPresentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: ATPresentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: ATPresentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: ATPresentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: ATPresentable?, animated: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func setRootModule(_ module: ATPresentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: ATPresentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
