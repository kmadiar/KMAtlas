//
//  AppDelegate.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: ATCoordinator = self.makeCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationCoordinator.start()
        return true
    }
    
    private func makeCoordinator() -> ATCoordinator {
        return ApplicationCoordinator(
            router: ATRouterImp(rootController: self.rootController),
            coordinatorFactory: ATCoordinatorFactoryImp()
        )
    }
}

