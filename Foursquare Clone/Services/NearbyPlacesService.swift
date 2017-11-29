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

    private let placesService: PlacesService
    private let userLocationService: UserLocationService

    init(userLocationService: UserLocationService,
         placesService: PlacesService) {
        self.userLocationService = userLocationService
        self.placesService = placesService
    }

    func fetchNearbyPlaces() -> Observable<LocationPlaces> {
        return userLocationService.getUserLocation()
            .flatMap({ (userLocation: CLLocation) -> Observable<LocationPlaces> in
                print("")
                print("user location")
                print(userLocation)
                return self.placesService.placesAround(latitude: userLocation.coordinate.latitude,
                                                       longitude: userLocation.coordinate.longitude)
            })
    }
}
