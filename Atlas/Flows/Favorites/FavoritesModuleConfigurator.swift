//  
//  FavoritesModuleConfigurator.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class FavoritesModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? FavoritesViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: FavoritesViewController) {
        let model = FavoritesModel()
        model.output = viewController
        
        viewController.model = model
    }
    
}
