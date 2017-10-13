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
        
    override func setUp() {
        super.setUp()
        
        container = Container()
        container.register(LocationManager.self) { _ in LocationManagerMock() }
            .inObjectScope(.container)
        container.register(UserLocationService.self) { r in
            UserLocationService.init(locationManager: r.resolve(LocationManager.self)!)
        }
    }
    
    func testDependencyDelegateShouldBeWrapperClass() {
        let locationManager = container.resolve(LocationManager.self)!
        let userLocationService: UserLocationService = container.resolve(UserLocationService.self)!
        
        XCTAssertTrue(locationManager.delegate === userLocationService)
    }
    
    func testShouldRequestUserPermission() {
        let locationManager: LocationManagerMock = container.resolve(LocationManager.self)! as! LocationManagerMock
        
        XCTAssertFalse(locationManager.calledRequestWhenInUseAuthorization)
        
        _ = container.resolve(UserLocationService.self)!
        
        XCTAssertTrue(locationManager.calledRequestWhenInUseAuthorization)
    }
    
}
