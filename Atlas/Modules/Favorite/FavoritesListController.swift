//
//  FavoritesListController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/27/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

class FavoritesListController: ATRootViewController, FavoritesView {
    var onItemSelect: ((FavoritesListItem) -> ())?
    
    var dataService: ATDataService!
}
