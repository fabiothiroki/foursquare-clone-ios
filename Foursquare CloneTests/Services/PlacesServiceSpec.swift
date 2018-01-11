//
//  PlacesServiceSpec.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 10/01/18.
//  Copyright © 2018 Fabio Hiroki. All rights reserved.
//

import XCTest
import Swinject
import Moya
import Moya_ModelMapper

class PlacesServiceSpec: XCTestCase {

    private var container: Container!
    private var placesService: PlacesService!

    override func setUp() {
        super.setUp()
    }

    func testShouldCompleteWithExpectedResponse() {
        let provider = MoyaProvider<PlacesApi>(stubClosure: MoyaProvider.immediatelyStub)
        placesService = PlacesService.init(provider: provider)

        var completed = false

        _ = placesService.placesAround(latitude: -23.5666151, longitude: -46.6463977)
            .subscribe(onError: { (_) in
                 XCTFail("Should not return error")
            }, onCompleted: {
                completed = true
                XCTAssertTrue(completed)
            })
    }
}
