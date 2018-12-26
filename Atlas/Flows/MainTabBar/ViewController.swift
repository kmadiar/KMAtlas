//
//  ViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    var m: ATNetworkDataManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        m = ATNetworkDataManager()
//
//        m.getRegions { (result) in
//            switch result {
//            case .success(let regions):
//                print(regions)
//                let c = self.m.getCountries(by: regions.first!, completion: { (regionResult) in
//                    switch regionResult {
//                    case .success(let countries):
//                        print(countries.count)
//                    default:
//                        break
//                    }
//                })
//                print(c.count)
//            default:
//                break
//            }
//        }
    }
}

class ATRootViewController: UIViewController {

    var activity: ATActivity!
    var alert: ATAlert!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

