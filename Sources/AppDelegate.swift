//
//  AppDelegate.swift
//  Promest
//
//  Created by Jeff Kereakoglow on 2/15/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?

    fileprivate var appCoordinator: AppCoordinator!
}


// MARK: - Application Delegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()

        return true
    }
}
