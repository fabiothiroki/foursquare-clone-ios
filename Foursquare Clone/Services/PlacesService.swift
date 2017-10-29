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
            return .requestParameters(parameters: ["ll": latitude], encoding: URLEncoding.queryString)

        }
    }

    var headers: [String: String]? {
        return nil
    }
}
