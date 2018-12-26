//
//  ATTabbarView.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

protocol ATTabbarView: AnyObject {
    var onAtlasFlowSelect: ((UINavigationController) -> ())? { get set }
    var onSearchFlowSelect: ((UINavigationController) -> ())? { get set }
    var onFavoritesFlowSelect: ((UINavigationController) -> ())? { get set }
    var onViewDidLoad: ((UINavigationController) -> ())? { get set }
}
