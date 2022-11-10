//
//  Project: CodingChallenge#2
//  AppDelegate.swift
//
//
//  Created by Jessica Ernst on 10.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        let mainView = ViewController()
        nav.viewControllers = [mainView]
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

}

