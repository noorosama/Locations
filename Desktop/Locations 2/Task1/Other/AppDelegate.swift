//
//  AppDelegate.swift
//  Task1
//
//  Created by Nour Abukhaled on 3/2/18.
//  Copyright © 2018 Nour Abukhaled. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    
    struct globalVariabels {
        
        static var isNotification: Bool = false
        static var branchNotification: String = ""
        static var ATMNotification: String = ""
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        // Override point for customization after application launch.
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    
        FirebaseApp.configure()
        
        return true
    }

    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        
       print(remoteMessage.appData)
        
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let state: UIApplicationState = UIApplication.shared.applicationState
        
        if state == .inactive {
            // user has tapped notification
            
            globalVariabels.branchNotification = userInfo["BranchID"] as? String ?? ""
            globalVariabels.ATMNotification = userInfo["ATMID"] as? String ?? ""
            globalVariabels.isNotification = true
        }
        else if state == .background {
            
            globalVariabels.isNotification = false
            
        }else{
            
            globalVariabels.isNotification = false
        }
        
       
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didReceiveNotification"), object: nil, userInfo: userInfo)
        
    }
   
    
}

