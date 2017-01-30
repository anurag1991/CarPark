//
//  CPStoryBoardID.swift
//  CarkPark
//
//  Created by Anurag Yadav on 1/30/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import UIKit

struct StoryBoardIdentifier {
    static let mapViewControllerIdentifier = "CPMapViewIdentifier"
    
}

class CPStoryBoardID: NSObject {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    static let sharedInstance = CPStoryBoardID()
    
    func mapViewController() -> CPMapViewController {
        let mapViewControllerObj = storyboard.instantiateViewController(withIdentifier: StoryBoardIdentifier.mapViewControllerIdentifier) as? CPMapViewController
        return mapViewControllerObj!

    }
}
