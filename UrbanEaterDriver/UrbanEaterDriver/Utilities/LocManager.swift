//
//  LocationManager.swift
//  DriverReadyToEat
//
//  Created by Casperon iOS on 21/11/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftLocation

class LocManager: NSObject
{
    static let shared = LocManager()
    
    func GetCurrentLocation(completionHandler : @escaping (_ lat : Double , _ lang: Double) -> () , onFail : (_ err : Error) -> () )
    {
        Locator.currentPosition(accuracy: .city, onSuccess: {location in
                        
            completionHandler(location.coordinate.latitude, location.coordinate.longitude)
            
        }, onFail: {err, last in
            
            print("err", err )
            
        })
    }
    
    func getBearingBetweenTwoPoints1( A: CLLocation, locationB B: CLLocation) -> Double
    {
        var dlon: Double = self.toRad((B.coordinate.longitude - A.coordinate.longitude))
        let dPhi: Double = log(tan(self.toRad(B.coordinate.latitude) / 2 + Double.pi / 4) / tan(self.toRad(A.coordinate.latitude) / 2 + Double.pi / 4))
        if fabs(dlon) > Double.pi {
            dlon = (dlon > 0) ? (dlon - 2 * Double.pi) : (2 * Double.pi + dlon)
        }
        return self.toBearing(atan2(dlon, dPhi))
    }
    
    func toRad(_ degrees: Double) -> Double {
        return degrees * (.pi / 180)
    }
    
    func toBearing(_ radians: Double) -> Double {
        return (self.toDegrees(radians) + 360) .truncatingRemainder(dividingBy: 360)
    }
    
    func toDegrees(_ radians: Double) -> Double {
        return radians * 180 / .pi
    }
    
    
    func getBearing(toPoint point: CLLocationCoordinate2D , fromLattitude : Double, fromLongitude : Double) -> Double
    {
        func degreesToRadians(degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
        func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / Double.pi }
        
        let lat1 = degreesToRadians(degrees: fromLattitude)
        let lon1 = degreesToRadians(degrees: fromLongitude)
        
        let lat2 = degreesToRadians(degrees: point.latitude);
        let lon2 = degreesToRadians(degrees: point.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
}
