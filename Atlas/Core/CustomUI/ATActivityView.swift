//
//  ATActivityView.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//
import MBProgressHUD

protocol ATActivity {
    func showActivity(in view: UIView)
    func hideActivity(in view: UIView)
}

extension MBProgressHUD: ATActivity {
    func showActivity(in view: UIView) {
        MBProgressHUD.atlas_showAdded(to: view, animated: true)
    }
    
    func hideActivity(in view: UIView) {
        MBProgressHUD.atlas_hide(for: view, animated: true)
    }
    
    // MARK: - HUD methods
    
    /// Show HUD with custom Pennybox style
    ///
    /// - Parameters:
    ///   - view: The view that the HUD will be added to
    ///   - animated: If set to YES the HUD will appear using the current animationType. If set to NO the HUD will not use
    /// - Returns: A reference to the created HUD
    class func atlas_showAdded(to view: UIView, animated: Bool) {
        _ = MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    /// Finds the top-most HUD subview and hides it. The counterpart to this method is penny_showAdded:animated:.
    ///
    /// - Parameters:
    ///   - view: The view that is going to be searched for a HUD subview
    ///   - animated: If set to YES the HUD will disappear using the current animationType. If set to NO the HUD will not use animations while disappearing.
    /// - Returns: `true` if a HUD was found and removed, `false` otherwise
    class func atlas_hide(for view: UIView, animated: Bool) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
    
    class func atlas_isAddedToView(view: UIView) -> Bool {
        return MBProgressHUD(for: view) != nil
    }
    
}
