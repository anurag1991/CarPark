//
//  ViewController.swift
//  CarkPark
//
//  Created by Anurag Yadav on 9/28/16.
//  Copyright © 2016 CarPark. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fbButton = FBSDKLoginButton()
        fbButton.center = self.view.center
        self.view.addSubview(fbButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

