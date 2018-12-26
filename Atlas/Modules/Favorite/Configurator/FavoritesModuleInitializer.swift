//  
//  FavoritesModuleInitializer.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class FavoritesModuleInitializer: NSObject {
    
    @IBOutlet weak var viewController: FavoritesViewController!
    
    override func awakeFromNib() {
        let configurator = FavoritesModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
    
}
