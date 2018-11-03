//
//  LocationService.swift
//
//
//  Created by Anak Mirasing on 5/18/2558 BE.
//
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func tracingLocation(_ currentLocation: CLLocation)
    func tracingLocationDidFailWithError(_ error: NSError)
    func ChangeStatus(_ Locstatus: CLAuthorizationStatus)

}
 class LocationService: NSObject, CLLocationManagerDelegate {
    static let sharedInstance: LocationService = {
        let instance = LocationService()
        return instance
    }()

    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    var Locstatus: CLAuthorizationStatus?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        Locstatus = CLLocationManager.authorizationStatus()
         if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice 
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            Locstatus = .notDetermined
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 10 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
     }
     func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {
            return
        }
        
        // singleton for get last(current) location
        currentLocation = location
        
        // use for real time update location
        updateLocation(location)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // do on error
        updateLocationDidFailWithError(error as NSError)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
             break
        case .authorizedWhenInUse:
            Locstatus = .authorizedWhenInUse

             break
        case .authorizedAlways:
            Locstatus = .authorizedWhenInUse
              break
        case .restricted:
            Locstatus = .restricted
             // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            Locstatus = .denied
             // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
        self.delegate?.ChangeStatus(status)
    }
    
    // Private function
    fileprivate func updateLocation(_ currentLocation: CLLocation){

        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation)
    }
    
    fileprivate func updateLocationDidFailWithError(_ error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error)
    }
}
