//
//  LoginViewController.swift
//  Agile
//
//  Created by KJ Studio on 2015. 12. 27..
//  Copyright © 2015년 KJStudio. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var fbLoginButton: UIButton!
    
    var userId:String = String()
    var userName:String = String()
    var isProfile:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnFBLoginPressed(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.returnUserData()
                    fbLoginManager.logOut()
                }
            }
        })
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                NSLog("Error: \(error)")
                NSLog("asdfasdfasdf")
            }
            else
            {
                let resultDic = result as? NSDictionary
                NSLog("asdf = %@", resultDic!)
                
                self.userId = resultDic!["id"] as! String
                self.userName = resultDic!["name"] as! String
                
                GeneralUtil.setUserId(self.userId)
                GeneralUtil.setUserName(self.userName)
                NSLog("userId = %@", GeneralUtil.getUserId())
                NSLog("userName = %@", GeneralUtil.getUserName())
                
                GeneralUtil.setUserLogedIn(true)
                GeneralUtil.setFacebookLogedIn(true)
                GeneralUtil.setLoginType("facebook")
                
                let facebookProfileURL = "http://graph.facebook.com/\(GeneralUtil.getUserId() as String)/picture?type=large"
                NSLog("facebookProfileURL = %@", facebookProfileURL)
                GeneralUtil.setFacebookProfileImageURL(facebookProfileURL)
                NSLog("페이스북 프로필 URL 확인 = %@", GeneralUtil.getFacebookProfileImageURL())
                NSLog("fetched user: \(result)")
                
                
                let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
                
                let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(forBlurEffect: blurEffect))
                blurView.frame = CGRectMake(87, 263, 146, 41)
                
                let activeIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
                activeIndicator.frame = CGRectMake(20, 11, 20, 20)
                blurView.addSubview(activeIndicator)
                
                let messageLabel:UILabel = UILabel()
                messageLabel.text = "로그인 중..."
                messageLabel.textColor = UIColor.whiteColor()
                messageLabel.font = UIFont.systemFontOfSize(17)
                messageLabel.frame = CGRectMake(48, 11, 78, 20)
                blurView.addSubview(messageLabel)
                
                self.view.addSubview(blurView)
                
                activeIndicator.startAnimating()
                
                ServerUtil.registerLogin(self.userId, reponseHandler: { handler -> Void in
                    NSLog("handler = %@", handler)
                    
                    let userProfile:NSDictionary = handler["userProfile"] as! NSDictionary!
                    
                    let iD:Int = userProfile["id"] as! Int
                    GeneralUtil.setUserId(String(iD))
//                    GeneralUtil.setTeamId(userProfile["team_id"] as! String)
                    
                    NSLog("user id = %@", GeneralUtil.getUserId() as String)
//                    NSLog("user team_id = %@", GeneralUtil.getTeamId() as String)
                    
                    
                    self.performSegueWithIdentifier("loginSegue", sender: UIButton())
                })
                
//                ServerUtil.registerUserInfo(GeneralUtil.getUserId() as String, userName: GeneralUtil.getUserName() as String, loginType: GeneralUtil.getLoginType() as String, userType: "performer", os: "iOS", deviceToken: "", phoneNum: "", description: GeneralUtil.getUserDesc() as String, imageURL: GeneralUtil.getFacebookProfileImageURL() as String, reponseHandler: { handler -> Void in
//                    NSLog("서버로 넘어갔당!!face = %@", handler)
//                    let belongId:String = handler["belongId"] as! String
//                    let hallId:String = handler["hallId"] as! String
//                    NSLog("belongId = %@", belongId)
//                    GeneralUtil.setBelongId(belongId)
//                    NSLog("general belongId = %@",GeneralUtil.getBelongId())
//                    NSLog("hallId = %@", hallId)
//                    GeneralUtil.setHallId(hallId)
//                    NSLog("general belongId = %@",GeneralUtil.getHallId())
//                    
//                    let userProfile:NSDictionary = handler["userProfile"] as! NSDictionary
//                    let phoneNum:String = userProfile["phoneNum"] as! String
//                    let userServerName:String = userProfile["userName"] as! String
//                    let regId:String = userProfile["id"] as! String
//                    let desc:String = userProfile["description"] as! String
//                    
//                    GeneralUtil.setRegId(regId)
//                    GeneralUtil.setUserPhoneNum(phoneNum)
//                    GeneralUtil.setUserDesc(desc)
//                    GeneralUtil.setUserName(userServerName)
//                    
//                    NSLog("유저 이름 = %@", GeneralUtil.getUserName() as String)
//                    NSLog("유저 폰 넘버 = %@", GeneralUtil.getUserPhoneNum() as String)
//                    NSLog("유저 소개글 = %@", GeneralUtil.getUserDesc() as String)
//                    
//                    NSLog("segue 실행")
//                    
//                    activeIndicator.stopAnimating()
//                    blurView.removeFromSuperview()
//                    
//                    NSLog("isProfile = %@", self.isProfile)
//                    NSLog("@@@@@@ = %d", (!GeneralUtil.getUserPhoneNum().isEqualToString("")))
//                    if self.isProfile && !GeneralUtil.getUserPhoneNum().isEqualToString("") {
//                        self.performSegueWithIdentifier("loginSegue", sender: UIButton())
//                    }
//                    else {
//                        self.performSegueWithIdentifier("profileSegue", sender: UIButton())
//                    }
//                })
                
            }
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
