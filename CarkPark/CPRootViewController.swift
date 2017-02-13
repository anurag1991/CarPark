//
//  CPRootViewController.swift
//  CarkPark
//
//  Created by Anurag Yadav on 1/31/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import UIKit
import AKSideMenu
import FBSDKCoreKit
import FBSDKLoginKit


public class CPRootViewController: AKSideMenu, AKSideMenuDelegate {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.default
        self.contentViewShadowColor = UIColor.black
        self.contentViewShadowOffset = CGSize(width: 0, height: 0)
        self.contentViewShadowOpacity = 0.6
        self.contentViewShadowRadius = 12
        self.contentViewShadowEnabled = true
        
        self.contentViewController = self.storyboard!.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.navigationControllerIdentifier)
        self.leftMenuViewController = self.storyboard!.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.menuListControllerIdentifier)
        self.backgroundImage = UIImage.init(named: "star")
        self.delegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - <AKSideMenuDelegate>
    
    public func sideMenu(_ sideMenu: AKSideMenu, willShowMenuViewController menuViewController: UIViewController) {
        print("willShowMenuViewController")
    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, didShowMenuViewController menuViewController: UIViewController) {
        print("didShowMenuViewController")
    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, willHideMenuViewController menuViewController: UIViewController) {
        print("willHideMenuViewController")
    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, didHideMenuViewController menuViewController: UIViewController) {
        print("didHideMenuViewController")
    }
}

