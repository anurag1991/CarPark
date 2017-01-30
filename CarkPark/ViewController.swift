//
//  ViewController.swift
//  CarkPark
//
//  Created by Anurag Yadav on 9/28/16.
//  Copyright © 2016 CarPark. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import LMSideBarController

class ViewController: UIViewController {
    
    //********* Need to put all FB code into wrapper class < CPSocialNetworkingManager >

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var label_emailid: UILabel!
    @IBOutlet weak var imageView_profilepic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.current()) != nil{
            let mapViewController = CPMapViewController()
            
self.navigationController?.pushViewController(mapViewController, animated: true)        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self)
        { (result, error) in
            if error != nil{
                print("login failed")
            }
            if (FBSDKAccessToken.current()) != nil{
                self.fetchFacebookUserProfile()
               // self.navigationController?.pushViewController(self.getMapViewControllerWith(Identifier: "CPMapViewIdentifier"), animated: true)
            }
        }
    }
    
    func getMapViewControllerWith(Identifier:String) -> CPMapViewController {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: Identifier) as? CPMapViewController
        return mapViewControllerObj!
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
            }
            
            if let picture = dictionary["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String{
                let pictureURL = NSURL(string: url)
                let data = NSData(contentsOf: pictureURL as! URL)
                self.imageView_profilepic.image = UIImage(data: data as! Data)
            }
            
        }
    }
}

