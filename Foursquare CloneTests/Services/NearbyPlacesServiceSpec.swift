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
    private var placesDatasource: PlacesApiMock!
    private var userLocationDatasource: UserLocationServiceMock!
    private var nearbyPlacesService: NearbyPlacesService!
    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

        container = Container()
        container.register(UserLocationDatasource.self) { _ in UserLocationServiceMock() }
            .inObjectScope(.container)
        container.register(PlacesDatasource.self) { _ in PlacesApiMock()}
            .inObjectScope(.container)
        container.register(NearbyPlacesService.self) { resolver in
            NearbyPlacesService.init(userLocationDatasource: resolver.resolve(UserLocationDatasource.self)!,
                                     placesDatasource: resolver.resolve(PlacesDatasource.self)!)}

        placesDatasource = container.resolve(PlacesDatasource.self)! as? PlacesApiMock
        userLocationDatasource = container.resolve(UserLocationDatasource.self)! as? UserLocationServiceMock
        nearbyPlacesService = container.resolve(NearbyPlacesService.self)
    }

    func testShouldResolveDependencies() {
        XCTAssertNotNil(placesDatasource)
        XCTAssertNotNil(userLocationDatasource)
        XCTAssertNotNil(nearbyPlacesService)
    }

    func testShouldRequestPlacesNearbyUserLocation() {
        _ = nearbyPlacesService.fetchNearbyPlaces()
            .subscribe(onNext: { (places) in
                XCTAssertNotNil(places)
            }, onError: { (_) in
                XCTFail("Should not return error")
            }).disposed(by: disposeBag)

        let mockUserLatitude = userLocationDatasource.location.coordinate.latitude
        let mockUserLongitude = userLocationDatasource.location.coordinate.longitude

        XCTAssertEqual(placesDatasource.requestedLatitude, mockUserLatitude)
        XCTAssertEqual(placesDatasource.requestedLongitude, mockUserLongitude)
    }
}
