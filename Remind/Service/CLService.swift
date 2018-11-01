//
//  CLService.swift
//  Remind
//
//  Created by SD on 01/11/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit
import CoreLocation

class CLService: NSObject {
    
    private override init() {}
    static let shared = CLService()
    
    var shouldSetRegion = true
    let locationManager = CLLocationManager()
    
    func authorize(){
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation(){
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location")
        guard let currentLocation = locations.first, shouldSetRegion else {return}
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("DID ENTER REGION VIA CL")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.EnteredRegion"), object: nil)
    }
}
