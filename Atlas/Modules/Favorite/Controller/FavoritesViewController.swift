//  
//  FavoritesViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    var model: FavoritesModelInput!
    lazy var contentView: FavoritesViewInput = { return view as! FavoritesViewInput }()
    
}

// MARK: - FavoritesModelOutput
extension FavoritesViewController: FavoritesModelOutput {}

// MARK: - FavoritesViewControllerInput
extension FavoritesViewController: FavoritesViewControllerInput {}
