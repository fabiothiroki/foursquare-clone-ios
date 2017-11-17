//
//  SwinjectStoryboard+Setup.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 25/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import CoreLocation

extension SwinjectStoryboard {
    class func setup() {
        defaultContainer.storyboardInitCompleted(ViewController.self) { resolver, container in
        }

        setupLocationDependencies()
        setupReducer()
    }

    class func setupLocationDependencies() {
        defaultContainer.register(LocationManager.self) { _ in CLLocationManager() }
        defaultContainer.register(UserLocationService.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }

    class func setupReducer() {
        defaultContainer.register(AppReducer.self) { resolver in
            AppReducer.init(userLocationService: resolver.resolve(UserLocationService.self)!)
        }
    }
}
