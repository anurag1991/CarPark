//
//  CPMenuList.swift
//  CarkPark
//
//  Created by Anurag Yadav on 9/28/16.
//  Copyright © 2016 CarPark. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

public class CPMenuList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var userData : UserData?
    
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tableView: UITableView = UITableView.init(frame: CGRect(x: 0, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5), style: UITableViewStyle.plain)
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleWidth]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.bounces = false
        
        self.tableView = tableView
        self.view.addSubview(self.tableView!)
        
        self.profilePictureImage.layer.cornerRadius = self.profilePictureImage.frame.size.width/2
        self.profilePictureImage.image = UserData.sharedInstance.userProfilePicture
        print(UserData.sharedInstance.userProfilePicture)
        print(UserData.sharedInstance.userName)
    }
    
    // MARK: - <UITableViewDelegate>
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        

     
        switch indexPath.row {
        case 3:
            FBSDKAccessToken.setCurrent(nil)
            self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: Constant.StoryBoardIdentifier.loginViewController)), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
          
      /*
        case 1:
            self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "secondViewController")), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
 */
            
        default:
            self.sideMenuViewController!.setContentViewController(CPStoryBoardID.sharedInstance.homeViewController(), animated: true)
            self.sideMenuViewController!.hideMenuViewController()
            break

        }
     }
    
    // MARK: - <UITableViewDataSource>
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Cell"
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.font = UIFont.init(name: "HelveticaNeue", size: 21)
            cell!.textLabel?.textColor = UIColor.white
            cell!.textLabel?.highlightedTextColor = UIColor.lightGray
            cell!.selectedBackgroundView = UIView.init()
        }
        
        
        var titles: [String] = ["Map", "Profile", "Settings", "Log Out"]
      //  var images: [String] = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        cell!.textLabel?.text = titles[indexPath.row]
        //cell!.imageView?.image = UIImage.init(named: images[indexPath.row])
        
        return cell!
    }
}
class CPImageView: UIImageView {
    
    override func setNeedsLayout() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true;
    }
    

}
