//
//  PlacesService.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 25/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import Foundation
import Moya

enum PlacesApi {
    case recommended(latitude: Double, longitude: Double)
}

extension PlacesApi: TargetType {
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
        switch self {
        case .recommended:
            return stubbedResponse("venues")
        }
    }

    var task: Task {
        switch self {
        case let .recommended(latitude, longitude):
            let parameters = requestParameters(latitude: latitude, longitude: longitude)
            return .requestParameters(parameters: parameters,
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

    private func stubbedResponse(_ filename: String) -> Data! {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")
        return (try? Data(contentsOf: url!))
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

let failureEndpointClosure = { (target: PlacesApi) -> Endpoint<PlacesApi> in
    let error = NSError(
        domain: "com.moya.moyaerror",
        code: 0,
        userInfo: [NSLocalizedDescriptionKey: "Houston, we have a problem"])

    return Endpoint<PlacesApi>(
        url: url(target),
        sampleResponseClosure: {.networkError(error)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
}
