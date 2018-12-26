//  
//  RegionsViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class RegionsViewController: UIViewController {
    
    var model: RegionsModelInput!
    lazy var contentView: RegionsViewInput = { return view as! RegionsViewInput }()
    
}

// MARK: - RegionsModelOutput
extension RegionsViewController: RegionsModelOutput {}

// MARK: - RegionsViewControllerInput
extension RegionsViewController: RegionsViewControllerInput {}
