//
//  GeneralUtil.swift
//  GongBack
//
//  Created by KJ Studio on 2015. 7. 1..
//  Copyright (c) 2015년 KJ Studio. All rights reserved.
//

import UIKit

class GeneralUtil: NSObject {
    
//    static func isFirstLogin
    
    static func setUserId(userId:NSString) {
        NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func getUserId() -> NSString {
        var userId:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userId")!
        
        if userId.isEqualToString("") {
            userId = "notLogin"
        }
        return userId
    }
    
    static func setUserName(userName:NSString) {
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func getUserName() -> NSString {
        var userName:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userName")!
        
        if userName.isEqualToString("") {
            userName = "notLogin"
        }
        return userName
    }
    
    static func setTeamId(teamId:NSString) {
        NSUserDefaults.standardUserDefaults().setObject(teamId, forKey: "teamId")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func getTeamId() -> NSString {
        var teamId:NSString = NSUserDefaults.standardUserDefaults().stringForKey("teamId")!
        
        if teamId.isEqualToString("") {
            teamId = "noTeamId"
        }
        return teamId
    }
    
    static func setUserLogedIn(login:Bool) {
        NSUserDefaults.standardUserDefaults().setBool(login, forKey: "login")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    static func isUserLogedIn() -> Bool {
        let login:Bool = NSUserDefaults.standardUserDefaults().boolForKey("login")
        
        return login
    }
    
//    static func setUserName(userName:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getUserName() -> NSString {
//        var userName:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userName")!
//        
//        if userName.isEqualToString("") {
//            userName = "비회원"
//        }
//        
//        return userName
//    }
//    
//    
//    static func setUserType(userType:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(userType, forKey: "userType")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getUserType() -> NSString {
//        var userType:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userType")!
//        
//        if userType.isEqualToString("") {
//            userType = "performer"
//        }
//        return userType
//    }
//    
//    static func setUserLogedIn(login:Bool) {
//        NSUserDefaults.standardUserDefaults().setBool(login, forKey: "login")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func isUserLogedIn() -> Bool {
//        let login:Bool = NSUserDefaults.standardUserDefaults().boolForKey("login")
//        
//        return login
//    }
//    
//    static func setLoginType(loginType:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(loginType, forKey: "loginType")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getLoginType() -> NSString {
//        let loginType:NSString = NSUserDefaults.standardUserDefaults().stringForKey("loginType")!
//        return loginType
//    }
//    
//    static func setFacebookLogedIn(fbLogin:Bool) {
//        NSUserDefaults.standardUserDefaults().setBool(fbLogin, forKey: "fbLogin")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func isFacebookLogedIn() -> Bool {
//        let fbLogin:Bool = NSUserDefaults.standardUserDefaults().boolForKey("fbLogin")
//        return fbLogin
//    }
//    
//    static func setKakaoLogedIn(kakaoLogin:Bool) {
//        NSUserDefaults.standardUserDefaults().setBool(kakaoLogin, forKey: "kakaoLogin")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func isKakaoLogedIn() -> Bool {
//        let kakaoLogin:Bool = NSUserDefaults.standardUserDefaults().boolForKey("kakaoLogin")
//        return kakaoLogin
//    }
//    
//    static func setDeviceToken(deviceToken:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(deviceToken, forKey: "deviceToken")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getDeviceToken() -> NSString{
//        return NSUserDefaults.standardUserDefaults().stringForKey("deviceToken")!
//    }
//
//    static func setProfileExist(profileExist:Bool) {
//        NSUserDefaults.standardUserDefaults().setBool(profileExist, forKey: "profileExist")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func isProfileExist() -> Bool {
//        return NSUserDefaults.standardUserDefaults().boolForKey("profileExist")
//    }
//
//    static func setNotReceivePush(notReceivePush:Bool) {
//        NSUserDefaults.standardUserDefaults().setBool(notReceivePush, forKey: "notReceivePush")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func notReceivePush() -> Bool {
//        return NSUserDefaults.standardUserDefaults().boolForKey("notReceivePush")
//    }
//    
//    static func updateFirstRun() {
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isFirstRun")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func isFirstRun() -> Bool {
//        let firstRun:Bool = NSUserDefaults.standardUserDefaults().boolForKey("isFirstRun")
//        
//        return firstRun
//    }
//    
//    
//    
//    static func setUserPhoneNum(userPhoneNum:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(userPhoneNum, forKey: "userPhoneNum")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    
//    
//    static func getUserPhoneNum() -> NSString {
//        var userPhoneNum:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userPhoneNum")!
//        
//        if userPhoneNum.isEqualToString("") {
//            userPhoneNum = ""
//        }
//        
//        NSLog("userPhoneNum = %@", userPhoneNum)
//        return userPhoneNum
//    }
//    
//    static func setUserDesc(userDesc:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(userDesc, forKey: "userDesc")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getUserDesc() -> NSString {
//        var userDesc:NSString = NSUserDefaults.standardUserDefaults().stringForKey("userDesc")!
//        
//        if userDesc.isEqualToString("") {
//            userDesc = ""
//        }
//        
//        return userDesc
//    }
//    
//    static func setRegId(regId:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(regId, forKey: "regId")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getRegId() -> NSString {
//        return NSUserDefaults.standardUserDefaults().stringForKey("regId")!
//    }
//    
//    static func setHallId(hallId:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(hallId, forKey: "hallId")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getHallId() -> NSString {
//        return NSUserDefaults.standardUserDefaults().stringForKey("hallId")!
//    }
//    
//    static func setBelongId(belongId:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(belongId, forKey: "belongId")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getBelongId() -> NSString {
//        return NSUserDefaults.standardUserDefaults().stringForKey("belongId")!
//    }
//    
//    static func setKakaoProfileImageURL(kakaoImageURL:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(kakaoImageURL, forKey: "kakaoImageURL")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getKakaoProfileImageURL() -> NSString {
//        return NSUserDefaults.standardUserDefaults().stringForKey("kakaoImageURL")!
//    }
//    
//    static func setFacebookProfileImageURL(facebookImageURL:NSString) {
//        NSUserDefaults.standardUserDefaults().setObject(facebookImageURL, forKey: "facebookImageURL")
//        NSUserDefaults.standardUserDefaults().synchronize()
//    }
//    
//    static func getFacebookProfileImageURL() -> NSString {
//        return NSUserDefaults.standardUserDefaults().stringForKey("facebookImageURL")!
//    }
    
}
