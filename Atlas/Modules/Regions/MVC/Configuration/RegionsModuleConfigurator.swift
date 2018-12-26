//  
//  RegionsModuleConfigurator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class RegionsModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? RegionsViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: RegionsViewController) {
        let model = RegionsModel()
        model.output = viewController
        
        viewController.model = model
    }
    
}
