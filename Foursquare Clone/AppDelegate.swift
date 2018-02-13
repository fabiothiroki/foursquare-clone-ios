//
//  AppDelegate.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import UIKit
import ReSwift

let injector: Injector = Injector()
let store = Store<FetchedPlacesState>(reducer: (injector.resolve(AppReducer.self)!).reduce, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
//        let rootViewController = injector.resolve(ViewController.self)
        let rootViewController = PlacesViewController(nibName: "PlacesViewController", bundle: nil)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        return true
    }
}
