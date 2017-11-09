//
//  PlacesService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 25/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Moya

enum PlacesService {
    case recommended(latitude: Double, longitude: Double)
}

extension PlacesService: TargetType {
    var baseURL: URL {
         return URL(string: "https://api.foursquare.com/v2")!
    }

    var path: String {
        switch self {
        case .recommended:
            return "/venues/explore"
        }
    }

    var method: Moya.Method {
        switch self {
        case .recommended:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .recommended(latitude, longitude):
            return .requestParameters(parameters: requestParameters(latitude: latitude, longitude: longitude),
                                      encoding: URLEncoding.queryString)

        }
    }

    var headers: [String: String]? {
        return nil
    }

    private func requestParameters(latitude: Double, longitude: Double) -> [String: Any] {
        return [
            "v": "20171029",
            "venuePhotos": 1,
            "limit": 10,
            "ll": String(format: "%f,%f", latitude, longitude),
            "client_id": ServicesContants.foursquareClientId,
            "client_secret": ServicesContants.foursquareClientSecret]
    }
}
