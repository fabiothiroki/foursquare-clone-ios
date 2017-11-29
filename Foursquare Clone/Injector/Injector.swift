//
//  Injector.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 23/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift
import Swinject
import CoreLocation
import Moya
import Moya_ModelMapper
import ReSwift

struct Injector {

    private let container: Container = Container()

    func setup() {
        setupControllers()
        setupLocationDependencies()
        setupProvider()
        setupReducer()
        setupState()
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }

    private func setupControllers() {
        container.register(ViewController.self) { resolver in
            let controller = ViewController()
            controller.store = resolver.resolve(Store<FetchedPlacesState>.self)
            return controller
        }
    }

    private func setupLocationDependencies() {
        container.register(LocationManager.self) { _ in CLLocationManager() }
        container.register(UserLocationService.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }

    private func setupProvider() {
        container.register(MoyaProvider<PlacesApi>.self) { _ in MoyaProvider<PlacesApi>() }
    }

    private func setupReducer() {
        container.register(AppReducer.self) { resolver in
            AppReducer.init(userLocationService: resolver.resolve(UserLocationService.self)!,
                            provider: resolver.resolve(MoyaProvider<PlacesApi>.self)!)
            }.initCompleted { (resolver, appReducer) in
                var reducer = appReducer
                reducer.store = resolver.resolve(Store<FetchedPlacesState>.self)
        }
    }

    private func setupState() {
        container.register(Store<FetchedPlacesState>.self) { resolver in
            Store<FetchedPlacesState>(reducer: (resolver.resolve(AppReducer.self)!).reduce, state: nil)
            }.inObjectScope(.container)
    }
}
