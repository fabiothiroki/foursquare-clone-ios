//
//  AppReducer.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 15/11/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import ReSwift

struct AppReducer {
    
    let userLocationService: UserLocationService
    
    init(userLocationService: UserLocationService) {
        self.userLocationService = userLocationService
    }

    func reducer(action: Action, state: FetchedPlacesState?) -> FetchedPlacesState {
        switch action {
        case _ as FetchPlacesAction:
            break
        case let action as SetPlacesAction:
            return FetchedPlacesState(places: Result.finished(action.places))
        default:
            break
        }

        return FetchedPlacesState(places: .loading)
    }
}
