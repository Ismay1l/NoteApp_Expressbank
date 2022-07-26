//
//  AppDelegate.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = NavigationViewController()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true
    }
}

