//
//  AppDelegate.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 31/12/17.
//  Copyright © 2017 louis vallaey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        return true
    }
}

