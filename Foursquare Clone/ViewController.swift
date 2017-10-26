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

class ViewController: UIViewController {

    let locationService = UserLocationService.init(locationManager: CLLocationManager())
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationService.subject.subscribe(onNext: { (location) in
           print(location)
        }).disposed(by: disposeBag)
    }
}
