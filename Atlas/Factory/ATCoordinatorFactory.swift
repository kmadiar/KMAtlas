//
//  ATCoordinatorFactory.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

protocol ATCoordinatorFactory {
    func makeTabbarCoordinatorBox() -> (coordinator: ATCoordinator, toPresent: ATPresentable?)
    func makeAtlasCoordinator(navController: UINavigationController?) -> ATCoordinator
    func makeSearchCoordinator(navController: UINavigationController?) -> ATCoordinator
    func makeFavoritesCoordinator(navController: UINavigationController?) -> ATCoordinator
}
