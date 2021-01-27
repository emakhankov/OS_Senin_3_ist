//
//  LocationManager.swift
//  IOS_Senin_3_ist
//
//  Created by Jenya on 26.01.2021.
//

import UIKit

import CoreLocation


struct LocationCoordinate {
    var lat: Double
    var lon: Double
    static func create(localion: CLLocation)->LocationCoordinate {
        return LocationCoordinate(lat: localion.coordinate.latitude, lon: localion.coordinate.longitude)
    }
}


class LocationManager: NSObject, CLLocationManagerDelegate {

    static let sharedInstance = LocationManager()
    
    var manager = CLLocationManager()
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    var blockForSave: ((LocationCoordinate)->Void)?
    
    func getCurrentLocation(block: ((LocationCoordinate)->Void)?)
    {
        
        //if CLLocationManager.authorizationStatus() != .authorizedWhenInUse // "Это уже deprecated
        if (manager.authorizationStatus != .authorizedWhenInUse)  &&  (manager.authorizationStatus != .authorizedAlways)
        {
            print("Пользователь не дал доступа к локации")
        }
        
        blockForSave = block
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .other
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lc = LocationCoordinate.create(localion: locations.last!)
        blockForSave?(lc)
        
        manager.stopUpdatingLocation()
    }
}
