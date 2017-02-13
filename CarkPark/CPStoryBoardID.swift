//
//  CPStoryBoardID.swift
//  CarkPark
//
//  Created by Anurag Yadav on 1/30/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    struct StoryBoardIdentifier {
        static let mapViewControllerIdentifier = "CPMapViewIdentifier"
        static let menuListControllerIdentifier = "CPMenuListIdentifier"
        static let navigationControllerIdentifier  = "navigationControllerIdentifier"
        static let loginViewController = "loginViewController"
    }
    struct FaceBookPermissions {
      static   let parameters = ["fields":"id,name,email,picture.type(large)"]
      static   let graphPath = "/me"
      static   let readPermission = ["email","public_profile"]
 
    }
}

class CPStoryBoardID: NSObject {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    static let sharedInstance = CPStoryBoardID()
    
    func mapViewController() -> CPMapViewController {
        let mapViewControllerObj = storyboard.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.mapViewControllerIdentifier) as? CPMapViewController
        return mapViewControllerObj!

    }
    
    func menuListViewController() -> CPMenuList {
        let menuListController = storyboard.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.menuListControllerIdentifier) as? CPMenuList
        return menuListController!
    }
    
    // Mark: Menu List Controllers
    
    func homeViewController() -> UIViewController {
        return UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.mapViewControllerIdentifier))
    }
}
