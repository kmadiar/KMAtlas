//
//  ViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

class ATRootViewController: UIViewController {

    var activity: ATActivity!
    var alert: ATAlert!
    
    var activityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 200))
        
        self.view.addSubview(activityView)
        
        activity.showActivity(in: activityView)
        
        ATHTTPClient().get([ATCountry].self) { [weak self] result in
            guard let strongSelf = self else { return }
            
            strongSelf.activity.hideActivity(in: strongSelf.activityView)
            switch result {
            case .success(let countries):
                print(countries.count)
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.alert.show(errorMessage: error.customDescription)
                }
                
            }

        }
        
//        ATHTTPClient().search([ATCountry].self, query: "a") { result in
//            print(result)
//        }
    }


}

