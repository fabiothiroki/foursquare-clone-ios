//
//  InjectorSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 24/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import XCTest
import Moya
import ReSwift

class InjectorSpec: XCTestCase {

    private var injector: Injector = Injector()

    override func setUp() {
        super.setUp()
        injector = Injector()
        injector.setup()
    }

    func testShouldResolveViewController() {
        let viewController = injector.resolve(ViewController.self)
        XCTAssertNotNil(viewController)
    }

    func testShouldResolveLocationDependencies() {
        let locationManager = injector.resolve(LocationManager.self)
        let userLocationService = injector.resolve(UserLocationDatasource.self)
        XCTAssertNotNil(locationManager)
        XCTAssertNotNil(userLocationService)
    }

    func testShouldResolveProvider() {
        let provider = injector.resolve(MoyaProvider<PlacesApi>.self)
        XCTAssertNotNil(provider)
    }

    func testShouldResolveReducer() {
        let reducer = injector.resolve(AppReducer.self)
        XCTAssertNotNil(reducer)
    }

    func testShouldResolveState() {
        let store = injector.resolve(Store<FetchedPlacesState>.self)
        XCTAssertNotNil(store)
    }
}
