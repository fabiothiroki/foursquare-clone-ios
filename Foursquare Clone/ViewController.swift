//
//  ViewController.swift
//  Foursquare Clone
//
//  Created by Fabio Hiroki on 08/10/17.
//  Copyright © 2017 Fabio Hiroki. All rights reserved.
//

import UIKit
import CoreLocation
import RxSwift
import Moya
import Moya_ModelMapper

class ViewController: UIViewController {

    let provider: MoyaProvider<PlacesApi> = MoyaProvider<PlacesApi>()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = provider.rx.request(.recommended(latitude: -23.5666151, longitude: -46.6463977))
            .map(to: LocationPlaces.self, keyPath: "response")
            .subscribe(onSuccess: { (place) in
                print(place)
            }, onError: { (error) in
                print(error)
            })
    }
}
