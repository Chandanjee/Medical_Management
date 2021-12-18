//
//  CoreLocationManager.swift
//  Decoy
//
//  Created by MAC on 18/12/21.
//

import UIKit
import CoreLocation
import MapKit
import LocalAuthentication

enum Result<T> {
  case success(T)
  case failure(Error)
}

class CoreLocationManager: NSObject {
    private let manager: CLLocationManager

       init(manager: CLLocationManager = .init()) {
           self.manager = manager
           super.init()
           manager.delegate = self
       }
    
    var newLocation: ((Result<CLLocation>) -> Void)?
        var didChangeStatus: ((Bool) -> Void)?

        var status: CLAuthorizationStatus {
            return CLLocationManager.authorizationStatus()
        }
    func requestLocationAuthorization() {
           manager.delegate = self
           manager.desiredAccuracy = kCLLocationAccuracyBest
           manager.requestWhenInUseAuthorization()
           if CLLocationManager.locationServicesEnabled() {
               manager.startUpdatingLocation()
               //locationManager.startUpdatingHeading()
           }
       }

       func getLocation() {
           manager.requestLocation()
       }

       deinit {
           manager.stopUpdatingLocation()
       }
}

extension CoreLocationManager: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       newLocation?(.failure(error))
       manager.stopUpdatingLocation()
   }

   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
           newLocation?(.success(location))
       }
       manager.stopUpdatingLocation()
   }

   func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       switch status {
       case .notDetermined, .restricted, .denied:
           didChangeStatus?(false)
       default:
           didChangeStatus?(true)
       }
   }
}
