//
//  UserLocationServiceSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 11/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import XCTest
import Swinject

class UserLocationServiceSpec: XCTestCase {

    var container: Container!
    var locationManager: LocationManagerMock!
    var userLocationService: UserLocationService!

    override func setUp() {
        super.setUp()

        container = Container()
        container.register(LocationManager.self) { _ in LocationManagerMock() }
            .inObjectScope(.container)
        container.register(UserLocationService.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }

        locationManager = container.resolve(LocationManager.self)! as? LocationManagerMock
        userLocationService = container.resolve(UserLocationService.self)!
    }

    func testDependencyDelegateShouldBeWrapperClass() {
        XCTAssertTrue(locationManager.delegate === userLocationService)
    }

    func testShouldRequestUserPermission() {
        XCTAssertFalse(locationManager.calledRequestWhenInUseAuthorization)
        _ = userLocationService.getUserLocation()
        XCTAssertTrue(locationManager.calledRequestWhenInUseAuthorization)
    }
}
