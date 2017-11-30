//
//  PlacesService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 29/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ModelMapper

protocol PlacesDatasource {
    func placesAround(latitude: Double, longitude: Double) -> Observable<LocationPlaces>
}

struct PlacesService: PlacesDatasource {

    private let provider: MoyaProvider<PlacesApi>

    init(provider: MoyaProvider<PlacesApi>) {
        self.provider = provider
    }

    func placesAround(latitude: Double, longitude: Double) -> Observable<LocationPlaces> {
        return self.provider.rx.request(.recommended(latitude: latitude,
                                                     longitude: longitude))
            .map(to: LocationPlaces.self, keyPath: "response")
            .asObservable()
    }
}
