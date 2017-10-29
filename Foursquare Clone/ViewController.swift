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

class ViewController: UIViewController {

    let locationService = UserLocationService.init(locationManager: CLLocationManager())
    let provider: MoyaProvider<PlacesService> = MoyaProvider<PlacesService>()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.getUserLocation().subscribe(onNext: { (location) in
           print(location)
        }).disposed(by: disposeBag)

        _ = provider.rx.request(.recommended(latitude: -23.5666151, longitude: -46.6463977))
            .subscribe(onSuccess: { (response) in
                var backToString = String(data: response.data, encoding: String.Encoding.utf8) as String!
                print(backToString)
            })
    }
}
