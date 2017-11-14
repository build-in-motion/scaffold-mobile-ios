//
//  AppDelegate.swift
//  App
//
//  Created by Stephen Bechtold on 11/14/17.
//  Copyright © 2017 Build in Motion. All rights reserved.
//

import UIKit
import InMotionUI

@UIApplicationMain
class AppDelegate: InMotionUIAppDelegate {
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let result = super.application(application, didFinishLaunchingWithOptions: launchOptions);
        if (result) {
            Styles.apply();
        }
        return result;
    }
    
}


