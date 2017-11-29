//
//  NearbyPlacesServiceSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 28/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import XCTest
import Swinject
import RxSwift
import CoreLocation
import Moya

class NearbyPlacesServiceSpec: XCTestCase {

    private var container: Container!

    override func setUp() {
        super.setUp()

        container = Container()
        container.register(LocationManager.self) { _ in LocationManagerMock() }
            .inObjectScope(.container)
        container.register(UserLocationService.self) { resolver in
            UserLocationService.init(locationManager: resolver.resolve(LocationManager.self)!)
        }
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
