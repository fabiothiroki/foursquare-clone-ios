//
//  PlacesServiceSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 10/01/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import XCTest
import Moya
import Moya_ModelMapper

class PlacesServiceSpec: XCTestCase {

    private var placesService: PlacesService!

    func testMapResponseToModel() {
        let provider = MoyaProvider<PlacesApi>(stubClosure: MoyaProvider.immediatelyStub)
        placesService = PlacesService.init(provider: provider)

        var responseData: LocationPlaces?

        _ = placesService.placesAround(latitude: -23.5666151, longitude: -46.6463977)
            .subscribe { event in
                switch event {
                case .next(let response):
                    responseData = response
                case .error:
                    XCTFail("Should not return error")
                case .completed:
                    XCTAssertNotNil(responseData)
                }
        }
    }

    func testShouldEmitTheCorrectError() {
        let provider = MoyaProvider<PlacesApi>(
            endpointClosure: failureEndpointClosure,
            stubClosure: MoyaProvider.immediatelyStub)
        placesService = PlacesService.init(provider: provider)

        _ = placesService.placesAround(latitude: -23.5666151, longitude: -46.6463977)
            .subscribe { event in
                switch event {
                case .next:
                    XCTFail("Should have errored")
                case .error(let error):
                    XCTAssertEqual(error.localizedDescription, "Houston, we have a problem")
                case .completed:
                    XCTFail("Should have errored")
            }
        }
    }
}
