//
//  ViewController.swift
//  CarkPark
//
//  Created by Anurag Yadav on 9/28/16.
//  Copyright © 2016 CarPark. All rights reserved.
//

import UIKit
import FBSDKLoginKit

enum UserloginType {
    case Facebook,GooglePlus
}

class ViewController: UIViewController  {
    
    //********* Need to put all FB code into wrapper class < CPSocialNetworkingManager >
    
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var label_emailid: UILabel!
    @IBOutlet weak var imageView_profilepic: UIImageView!
    
    var userData : UserData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CPSocialNetworkingManager.sharedInstance.delegate = self
        if (FBSDKAccessToken.current()) != nil{
            self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        CPSocialNetworkingManager.sharedInstance.userLogInCall(loginType: UserloginType.Facebook, viewController: self)
    }
    
    func postDataToMenuListController(withUserData userData:UserData)
    {
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"MyNotification"),
                object: nil,
                userInfo: ["userName":userData.userName , "image":userData.userProfilePicture,"email":userData.userEmailAddress])
    }

}

extension ViewController : CPSocialManagerDelegate{
    
    func didFailWithError(error: NSError) {
        // need to show alert message based on error typr
    }
    
    func didLoadUserProfileSuccess(dictionary: Dictionary<String, Any>) {
        guard let email = dictionary["email"] as? String,
            let name =  dictionary["name"] as? String,
            let picture = dictionary["picture"] as? NSDictionary, let object = picture["data"] as? NSDictionary, let url = object["url"] as? String else {
                print("error parsing")
                return
        }
        let pictureURL = NSURL(string: url)
        let data = NSData(contentsOf: pictureURL as! URL)
        let userData = UserData.init(withUserName: name, userEmailAddress: email, profilePicture: UIImage(data: data as! Data)!)
        userData.writeDataIntoUserDefaults()
        self.postDataToMenuListController(withUserData: userData)
        self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
    }
}
