//
//  ViewController.swift
//  Atlas
//
//  Created by Kostiantyn Madiar on 12/25/18.
//  Copyright © 2018 Kostiantyn Madiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ATHTTPClient().get([ATCountry].self) { (result) in
            print(result)
        }
    }


}

