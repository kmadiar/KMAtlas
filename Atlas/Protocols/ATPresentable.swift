//
//  ATPresentable.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import UIKit

protocol ATPresentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: ATPresentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}
