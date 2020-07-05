//
//  AppDelegate.swift
//  CarMa
//
//  Created by Dianprakasa, Arif on 1/29/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit
import GoogleSignIn
import GoogleMaps
import Braintree


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         GIDSignIn.sharedInstance().clientID = "126168695609-e8gaog6neqoucuciinvuvkgs9errgq3f.apps.googleusercontent.com"
        GMSServices.provideAPIKey("AIzaSyCfQQkEybSaftydOg-LtbqCqSK9aJDGTRA")
        BTAppSwitch.setReturnURLScheme("team05.CarMa.payments")
        return true
    }
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      if url.scheme?.localizedCaseInsensitiveCompare("team05.CarMa.payments") == .orderedSame {
                    return BTAppSwitch.handleOpen(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
                }
        return GIDSignIn.sharedInstance().handle(url)
      
        }
        
        }
     

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }




    
    




