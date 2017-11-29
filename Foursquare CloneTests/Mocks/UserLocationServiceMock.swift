//
//  UserLocationServiceMock.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 29/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

struct UserLocationServiceMock: UserLocationDatasource {

    let location = CLLocation.init(latitude: -23.5666151, longitude: -46.6463977)

    func getUserLocation() -> Observable<CLLocation> {
        return Observable.from(optional: location)
    }
}
