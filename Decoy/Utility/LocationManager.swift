//
//  LocationManager.swift
//  Decoy
//
//  Created by MAC on 24/11/21.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

/// Notification on update of location. UserInfo contains CLLocation for key "location"
let kLocationDidChangeNotification = "LocationDidChangeNotification"

class UserLocationManager: NSObject, CLLocationManagerDelegate {

    static let SharedManager = UserLocationManager()

    private var locationManager = CLLocationManager()

    var currentLocation : CLLocation?

    var delegate : LocationUpdateProtocol!

    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        currentLocation = newLocation
        let userInfo : NSDictionary = ["location" : currentLocation!]

        self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
        NotificationCenter.default.post(name: Notification.Name(rawValue: kLocationDidChangeNotification), object: self,userInfo: userInfo as [NSObject:AnyObject])
//        DispatchQueue.main.async(execute:  { () -> Void in
//            self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
//            NotificationCenter.default.postNotification.Name(kLocationDidChangeNotification, object: self, userInfo: userInfo as [NSObject : AnyObject])
//        })
    }

}
