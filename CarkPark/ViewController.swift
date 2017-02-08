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
    
    //********* Need to put all FB code into wrapper class < CPSocialNetworkingManager >
    
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var label_emailid: UILabel!
    @IBOutlet weak var imageView_profilepic: UIImageView!
    
    var userData : UserData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (FBSDKAccessToken.current()) != nil{
            self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
<<<<<<< HEAD
        
        // Dispose of any resources that can be recreated.
=======
>>>>>>> master
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self)
        { (result, error) in
            if error != nil{
                print("login failed")
            }
            if (FBSDKAccessToken.current()) != nil{
<<<<<<< HEAD
                self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
            }
=======
                self.fetchFacebookUserProfile()
>>>>>>> master
        }
    }
    
    
    func fetchFacebookUserProfile()  {
        FBSDKGraphRequest.init(graphPath: "/me", parameters: ["fields":"id,name,email,picture.type(large)"]).start { (connection, result, error) in
            if error != nil{
                print("login failed")
            }
            guard let dictionary =  result as? Dictionary<String,AnyObject> else {
                print("error print man")
                return
            }
            if let email = dictionary["email"] as? String{
                self.label_emailid.text = email
                
            }
            if let name = dictionary["name"] as? String{
                self.label_name.text = name
                UserData.sharedInstance.userName = name
            }
            
            if let picture = dictionary["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String{
                let pictureURL = NSURL(string: url)
                let data = NSData(contentsOf: pictureURL as! URL)
                self.imageView_profilepic.image = UIImage(data: data as! Data)
                UserData.sharedInstance.userProfilePicture = UIImage(data: data as! Data)
                print(UserData.sharedInstance.userName)
                self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
            }
        }
    }
}

