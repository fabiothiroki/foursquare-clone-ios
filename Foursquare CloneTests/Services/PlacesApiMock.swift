//
//  PlacesApiMock.swift
//  Foursquare CloneTests
//
//  Created by Fabio Hiroki on 28/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import RxSwift

class PlacesApiMock: PlacesDatasource {

    var requestedLatitude: Double?
    var requestedLongitude: Double?

    func placesAround(latitude: Double, longitude: Double) -> Observable<LocationPlaces> {
        requestedLatitude = latitude
        requestedLongitude = longitude

        return Observable.of(LocationPlaces())
    }
}
