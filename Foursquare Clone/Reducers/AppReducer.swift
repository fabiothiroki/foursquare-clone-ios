//
//  AppReducer.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import Moya
import Moya_ModelMapper
import CoreLocation

struct AppReducer {

    let userLocationService: UserLocationService
    let provider: MoyaProvider<PlacesApi>
    let disposeBag = DisposeBag()
    weak var store: Store<FetchedPlacesState>?

    init(userLocationService: UserLocationService,
         provider: MoyaProvider<PlacesApi>) {
        self.userLocationService = userLocationService
        self.provider = provider
    }

    func reduce(action: Action, state: FetchedPlacesState?) -> FetchedPlacesState {
        switch action {
        case _ as FetchPlacesAction:
            _ = userLocationService.getUserLocation()
                .flatMap({ (userLocation: CLLocation) -> Single<LocationPlaces> in
                    print("")
                    print("user location")
                    print(userLocation)
                    return self.provider.rx.request(.recommended(latitude: userLocation.coordinate.latitude,
                                                                 longitude: userLocation.coordinate.latitude))
                    .map(to: LocationPlaces.self, keyPath: "response")
                })
                .subscribe({ (event) in
                    switch event {
                    case .next(let places):
                        print("")
                        print("places")
                        print(places)
                        self.store?.dispatch(SetPlacesAction(places: places))
                    case .error(let error):
                        print("")
                        print(error)
                        self.store?.dispatch(SetErrorAction(error: error))
                    case .completed:
                        break
                    }
                }).disposed(by: disposeBag)
        case let action as SetPlacesAction:
            return FetchedPlacesState(places: Result.finished(action.places))
        default:
            break
        }

        return FetchedPlacesState(places: .loading)
    }
}
