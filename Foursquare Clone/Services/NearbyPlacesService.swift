//
//  NearbyPlacesService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 28/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ModelMapper
import CoreLocation

struct NearbyPlacesService {

    private let placesDatasource: PlacesDatasource
    private let userLocationDatasource: UserLocationDatasource

    init(userLocationDatasource: UserLocationDatasource,
         placesDatasource: PlacesDatasource) {
        self.userLocationDatasource = userLocationDatasource
        self.placesDatasource = placesDatasource
    }

    func fetchNearbyPlaces() -> Observable<LocationPlaces> {
        return userLocationDatasource.getUserLocation()
            .flatMap({ (userLocation: CLLocation) -> Observable<LocationPlaces> in
                return self.placesDatasource.placesAround(latitude: userLocation.coordinate.latitude,
                                                       longitude: userLocation.coordinate.longitude)
            })
    }
}
