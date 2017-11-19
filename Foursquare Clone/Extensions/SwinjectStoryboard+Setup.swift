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
import Moya
import Moya_ModelMapper
import ReSwift

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
        defaultContainer.register(Store<FetchedPlacesState>.self) { resolver in
            Store<FetchedPlacesState>(reducer: (resolver.resolve(AppReducer.self)!).reduce, state: nil)
        }.inObjectScope(.container)

        defaultContainer.register(MoyaProvider<PlacesApi>.self) { _ in MoyaProvider<PlacesApi>() }

        defaultContainer.register(AppReducer.self) { resolver in
            AppReducer.init(userLocationService: resolver.resolve(UserLocationService.self)!,
                            provider: resolver.resolve(MoyaProvider<PlacesApi>.self)!)
            }.initCompleted { (resolver, appReducer) in
                var reducer = appReducer
                reducer.store = resolver.resolve(Store<FetchedPlacesState>.self)
            }
    }
}
