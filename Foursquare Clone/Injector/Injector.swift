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

struct Injector {

    private let container: Container = Container()

    init() {
        setup()
    }

    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }

    private func setup() {
        setupControllers()
        setupLocationDependencies()
        setupProvider()
        setupNearbyPlacesService()
        setupReducer()
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
        container.register(UserLocationDatasource.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }

    private func setupProvider() {
        container.register(MoyaProvider<PlacesApi>.self) { _ in MoyaProvider<PlacesApi>() }
    }

    private func setupNearbyPlacesService() {
        container.register(PlacesDatasource.self) { resolver in
            PlacesService.init(provider: resolver.resolve(MoyaProvider<PlacesApi>.self)!)
        }
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService.init(userLocationDatasource: resolver.resolve(UserLocationDatasource.self)!,
                                     placesDatasource: resolver.resolve(PlacesDatasource.self)!)
        }
    }

    private func setupReducer() {

        container.register(AppReducer.self) { resolver in
            AppReducer.init(resolver.resolve(NearbyPlacesService.self)!)
        }
    }
}
