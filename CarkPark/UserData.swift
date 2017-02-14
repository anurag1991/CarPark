//
//  UserData.swift
//  CarkPark
//
//  Created by Anurag Yadav on 2/7/17.
//  Copyright © 2017 CarPark. All rights reserved.
//

import Foundation
import UIKit

class UserData {
    
    public var userName : String
    public var userEmailAddress : String
    public var userProfilePicture : UIImage
    
    
    internal var userDefault = UserDefaults.standard
    
    init(withUserName userName : String ,userEmailAddress : String, profilePicture : UIImage) {
        self.userName = userName
        self.userProfilePicture = profilePicture
        self.userEmailAddress = userEmailAddress
    }
    
    convenience init() {
        self.init(withUserName: "", userEmailAddress: "", profilePicture: UIImage())
    }
    
    func writeDataIntoUserDefaults()  {
        print(self.userName,self.userEmailAddress,self.userProfilePicture)
        let userDataDict = ["userName":self.userName,"emailAdd" : self.userEmailAddress,"imageName":"profile.jpg"]
        self.writeImageToDocumentDirectory(image: userProfilePicture)
        userDefault.set(userDataDict, forKey: "userData")
    }
    
    func retriveDataFromUserDefaults() -> (userName:String,userEmail:String,image:UIImage) {
        
        guard let userDataDict = userDefault.value(forKey: "userData") as? Dictionary<String,String> else {
            return ("","",UIImage.init(named: "girl-1252995_1280")!)
        }
        self.userName = userDataDict["userName"]!
        self.userEmailAddress = userDataDict["emailAdd"]!
        self.userProfilePicture = self.getImageFromDocumentryDirectory(withImageName: "profile.jpg")
        return (self.userName,self.userEmailAddress,self.userProfilePicture)
    }
    
    func writeImageToDocumentDirectory(image : UIImage)  {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("profile.jpg")
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getImageFromDocumentryDirectory(withImageName imageName:String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("profile.jpg")
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage()
    }
    
    func removeAllDataOfUser()  {
        userDefault.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        userDefault.synchronize()
    }
}

