//
//  UIViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/26/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

/// Helpers to create some layout constraints
private typealias UIViewLayoutCreationExtension = UIView

extension UIViewLayoutCreationExtension {
    
    // MARK: - Pin to edge
    
    /// Pin `subview` to current view by side constraint
    ///
    /// - Parameters:
    ///   - subview: Child view
    ///   - attribute: Bottom/Top/Leading/Trailing
    ///   - offset: Offset value from current view's sides
    /// - Returns: Created constraint
    @discardableResult
    func atlas_pinSubview(subview: UIView, toEdge attribute: NSLayoutConstraint.Attribute, itemEdge itemAttribute: NSLayoutConstraint.Attribute? = nil, edgeOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: subview, attribute: itemAttribute ?? attribute, multiplier: 1.0, constant: offset)
        //        addConstraint(constraint)
        constraint.isActive = true
        return constraint
    }
    
    /// Pin `subview` to current view with each side constraints
    ///
    /// - Parameter subview: Child view
    func atlas_pinAllEdgesOfSubview(subview: UIView) {
        _ = atlas_pinSubview(subview: subview, toEdge: .bottom)
        _ = atlas_pinSubview(subview: subview, toEdge: .top)
        _ = atlas_pinSubview(subview: subview, toEdge: .leading)
        _ = atlas_pinSubview(subview: subview, toEdge: .trailing)
    }
    
    // MARK: - Width, Height
    
    /// Add width constraint
    ///
    /// - Parameter constant: Constant value
    /// - Returns: Created constraint
    @discardableResult
    func atlas_addWidthConstraint(constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        //        addConstraint(constraint)
        constraint.isActive = true
        return constraint
    }
    
    /// Add height constraint
    ///
    /// - Parameter constant: Constant value
    /// - Returns: Created constraint
    @discardableResult
    func atlas_addHeightConstraint(constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
        //        addConstraint(constraint)
        constraint.isActive = true
        return constraint
    }
}
