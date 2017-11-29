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

    private let provider: MoyaProvider<PlacesApi>
    private let userLocationService: UserLocationService

    init(userLocationService: UserLocationService,
         provider: MoyaProvider<PlacesApi>) {
        self.userLocationService = userLocationService
        self.provider = provider
    }

    func fetchNearbyPlaces() -> Observable<LocationPlaces> {
        return userLocationService.getUserLocation()
            .flatMap({ (userLocation: CLLocation) -> Single<LocationPlaces> in
                print("")
                print("user location")
                print(userLocation)
                return self.provider.rx.request(.recommended(latitude: userLocation.coordinate.latitude,
                                                                  longitude: userLocation.coordinate.longitude),
                                                     callbackQueue: nil)
                    .map(to: LocationPlaces.self, keyPath: "response")
            })
    }
}
