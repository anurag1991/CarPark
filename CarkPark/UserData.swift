//
//  UserData.swift
//  CarkPark
//
//  Created by Anurag Yadav on 2/7/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import UIKit

class UserData: NSObject {
    
    public var userName : String?
    public var userProfilePicture : UIImage?
    
    static let sharedInstance = UserData()
}

