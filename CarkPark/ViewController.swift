//
//  ViewController.swift
//  CarkPark
//
//  Created by Anurag Yadav on 9/28/16.
//  Copyright © 2016 CarPark. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    //********* Need to put all FB code into wrapper class < CPSocialNetworkingManager >
    
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var label_emailid: UILabel!
    @IBOutlet weak var imageView_profilepic: UIImageView!
    
    //Google
    @IBOutlet weak var signInButton:        GIDSignInButton!
    @IBOutlet weak var signOutButton:       UIButton!
    @IBOutlet weak var disconnectButton:    UIButton!
    @IBOutlet weak var statusText:          UILabel!
    
    var userData : UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Google
        GIDSignIn.sharedInstance().uiDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
        statusText.text = "Initialize CarPark app"
        toggleAuthUI()
        
        //Facebook
        if (FBSDKAccessToken.current()) != nil{
            self.navigationController?.pushViewController(CPStoryBoardID.sharedInstance.mapViewController(), animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Facebook Methods
    @IBAction func facebookLogin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self)
        { (result, error) in
            if error != nil{
                print("login failed")
            }
            if (FBSDKAccessToken.current()) != nil{
                self.fetchFacebookUserProfile()
            }
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
    
    // MARK: Google Methods
    @IBAction func didTapSignOut(_ sender: AnyObject)
    {
        GIDSignIn.sharedInstance().signOut()
        statusText.text = "Signed out."
        toggleAuthUI()
    }
    
    @IBAction func didTapDisconnect(_ sender: AnyObject)
    {
        GIDSignIn.sharedInstance().disconnect()
        statusText.text = "Disconnecting"
    }
    
    func toggleAuthUI()
    {
        if GIDSignIn.sharedInstance().hasAuthInKeychain()
        {
            signInButton.isHidden       = true
            signOutButton.isHidden      = false
            disconnectButton.isHidden   = false
        }
        
        else
        {
            signInButton.isHidden       = false
            signOutButton.isHidden      = true
            disconnectButton.isHidden   = true
            statusText.text             = "Google Sign in\nCarPark"
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ToggleAuthNotification"), object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(_ notificaiton: NSNotification)
    {
        if notificaiton.name.rawValue == "ToggleAuthUINotification"
        {
            if notificaiton.userInfo != nil
            {
                guard let userInfo      = notificaiton.userInfo as? [String:String] else { return }
                self.statusText.text    = userInfo["statusText"]!
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController)
    {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

