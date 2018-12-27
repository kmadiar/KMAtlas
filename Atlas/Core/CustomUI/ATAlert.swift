//
//  ATAlert.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import Foundation
import BRYXBanner

protocol ATAlert {
    func show(errorMessage: String)
}

class ATInformer: ATAlert {
    
    // MARK: - Private API
    private struct Constants {
        static let errorMessageBgColor = UIColor.red
        static let showingTime: TimeInterval = 3.0
    }
    
    private static var banners: [Banner] = []
    
    private class func show(message: String, backgroundColor: UIColor, didTapBlock: (() -> Void)?) {
        // Dismiss old banner
        ATInformer.banners.forEach { $0.dismiss() }
        
        // Show new banner
        let banner = Banner(title: message, backgroundColor: backgroundColor)
        banner.titleLabel.textAlignment = .center
        banner.dismissesOnTap = didTapBlock == nil
        banner.didTapBlock = didTapBlock
        banner.didDismissBlock = { [weak banner] in
            if let banner = banner, let index = banners.index(of: banner) {
                banners.remove(at: index)
            }
        }
        ATInformer.banners.append(banner)
        banner.show(duration: Constants.showingTime)
    }
    
    func show(errorMessage: String) {
        ATInformer.show(message: errorMessage, backgroundColor: Constants.errorMessageBgColor, didTapBlock: nil)
    }
}
