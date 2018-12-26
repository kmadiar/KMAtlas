//
//  UIVIewControllerExtension.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

extension UIViewController {
    
    private class func atlas_instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    class func atlas_controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return atlas_instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    
    class func atlas_controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        return atlas_controllerInStoryboard(storyboard, identifier: nameOfClass)
    }
    
    class func atlas_controllerFromStoryboard(_ storyboard: Storyboards) -> Self {
        return atlas_controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: nameOfClass)
    }
}
