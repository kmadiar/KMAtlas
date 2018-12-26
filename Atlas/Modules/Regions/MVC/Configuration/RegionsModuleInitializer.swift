//  
//  RegionsModuleInitializer.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class RegionsModuleInitializer: NSObject {
    
    @IBOutlet weak var viewController: RegionsViewController!
    
    override func awakeFromNib() {
        let configurator = RegionsModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
    
}
