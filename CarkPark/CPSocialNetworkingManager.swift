//
//  CPSocialNetworkingManager.swift
//  CarkPark
//
//  Created by Anurag Yadav on 1/25/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import FBSDKLoginKit

protocol CPSocialManagerDelegate : class {
    func didFailWithError(error: NSError)
    func didLoadUserProfileSuccess(dictionary : Dictionary<String,Any>)
}

class CPSocialNetworkingManager: NSObject {
    
    static let sharedInstance = CPSocialNetworkingManager ()
    internal weak var delegate: CPSocialManagerDelegate?
    
    
    public func userLogInCall(loginType : UserloginType , viewController : UIViewController){
        if loginType == UserloginType.Facebook {
            self.faceBookLogin(viewController: viewController)
        }else{
            // Call Google plus login
        }
    }
    
    // MARK: -Facebook functions
    
    private func faceBookLogin(viewController :UIViewController){
        FBSDKLoginManager().logIn(withReadPermissions: Constant.FaceBookPermissions.readPermission, from: viewController)
        { (result, error) in
            if error != nil{
                self.delegate?.didFailWithError(error: error as! NSError)
            }
            if (FBSDKAccessToken.current()) != nil{
                self.fetchFacebookUserProfile()
            }
        }
    }
    
    func fetchFacebookUserProfile()  {
        FBSDKGraphRequest.init(graphPath: Constant.FaceBookPermissions.graphPath, parameters: Constant.FaceBookPermissions.parameters).start { (connection, result, error) in
            if error != nil{
                self.delegate?.didFailWithError(error: error as! NSError)
                return
            }
            guard let dictionary = result as? Dictionary<String,AnyObject> else{
                return (self.delegate?.didFailWithError(error: error as! NSError))!
            }
            self.delegate?.didLoadUserProfileSuccess(dictionary: dictionary)
        }
    }
}
