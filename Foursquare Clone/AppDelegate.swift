//
//  AppDelegate.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import UIKit
import ReSwift
import Swinject
import CoreLocation
import Moya
import Moya_ModelMapper
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container: Container = Container()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupLocationDependencies()
        setupReducer()
        container.register(ViewController.self) { resolver in
            let controller = ViewController()
            controller.store = resolver.resolve(Store<FetchedPlacesState>.self)
            return controller
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        window.rootViewController = container.resolve(ViewController.self)
        return true
    }

    func setupLocationDependencies() {
        container.register(LocationManager.self) { _ in CLLocationManager() }
        container.register(UserLocationService.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }

    func setupReducer() {
        container.register(MoyaProvider<PlacesApi>.self) { _ in MoyaProvider<PlacesApi>() }

        container.register(AppReducer.self) { resolver in
            AppReducer.init(userLocationService: resolver.resolve(UserLocationService.self)!,
                            provider: resolver.resolve(MoyaProvider<PlacesApi>.self)!)
            }.initCompleted { (resolver, appReducer) in
                var reducer = appReducer
                reducer.store = resolver.resolve(Store<FetchedPlacesState>.self)
        }

        container.register(Store<FetchedPlacesState>.self) { resolver in
            Store<FetchedPlacesState>(reducer: (resolver.resolve(AppReducer.self)!).reduce, state: nil)
            }.inObjectScope(.container)

    }
}
