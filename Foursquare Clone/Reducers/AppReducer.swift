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

    fileprivate let nearbyPlacesService: NearbyPlacesService
    fileprivate let disposeBag = DisposeBag()

    init(_ nearbyPlacesService: NearbyPlacesService) {
        self.nearbyPlacesService = nearbyPlacesService
    }

    func reduce(action: Action, state: FetchedPlacesState?) -> FetchedPlacesState {
        switch action {
        case _ as FetchPlacesAction:
            _ = nearbyPlacesService.fetchNearbyPlaces()
                .subscribe({ (event) in
                    switch event {
                    case .next(let places):
                        store.dispatch(SetPlacesAction(places: places))
                    case .error(let error):
                        store.dispatch(SetErrorAction(error: error))
                    case .completed:
                        break
                    }
                }).disposed(by: disposeBag)
        case let action as SetPlacesAction:
            return FetchedPlacesState(places: Result.finished(action.places))
        case _ as SetErrorAction:
            return FetchedPlacesState(places: Result.failed)
        default:
            break
        }

        return FetchedPlacesState(places: .loading)
    }
}
