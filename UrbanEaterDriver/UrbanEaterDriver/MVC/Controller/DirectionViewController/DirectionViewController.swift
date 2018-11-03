//
//  DirectionViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 19/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class DirectionViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var mapview: GMSMapView!
    
    var restarantMarker = GMSMarker()
    var driverMarker = GMSMarker()
    var latRestarant = 0.00000;
    var langRestarant = 0.00000;
    
    var Latitude:String = String()
    var Longitude:String = String()
    var current_Location:CLLocation?
    
    var latLongRestarant: LocationRecord = LocationRecord.init()
    
    var phNoRestarant = "9032363049"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.sharedInstance.delegate = self
        LocationService.sharedInstance.startUpdatingLocation()
        
        //  print("Restarant lattitude ---->> ", latLongRestarant.lattitude.doubleValue)
        //  print("Restarant longitude ---->> ", latLongRestarant.longitude.doubleValue)
        
        if latLongRestarant.lattitude.doubleValue != nil
        {
            self.latRestarant = latLongRestarant.lattitude.doubleValue!
            
        }
        
        if latLongRestarant.longitude.doubleValue != nil
        {
            self.langRestarant = latLongRestarant.longitude.doubleValue!
            
        }
        self.latRestarant = 17.4505
        self.langRestarant = 78.3809
        
        self.restarantMarker.position = CLLocationCoordinate2DMake(latRestarant, langRestarant)
        
        self.restarantMarker.icon = #imageLiteral(resourceName: "markerRestarant")
        
        self.restarantMarker.map = self.mapview
        
        //  self.name.text = self.restaurantname
        
        /* ******** */
        
        // self.buttonStartTrip.isEnabled = false;
        
        LocManager.shared.GetCurrentLocation(completionHandler: { lat , long in
            
            self.Latitude = "\(lat)"
            self.Longitude = "\(long)"
            
            print("self.Latitude ---->> ", self.Latitude)
            print("self.Longitude ---->> ", self.Longitude)
            
            self.driverMarker.position = CLLocationCoordinate2DMake(Double(self.Latitude)!, Double(self.Longitude)!)
            
            self.driverMarker.icon = #imageLiteral(resourceName: "bikeImage")
            
            self.driverMarker.map = self.mapview
            
            //            self.DrawLine(fromLat: lat, fromLong: long, toLat: self.latRestarant, toLong: self.langRestarant)
            
            print("latRestarant ---->> ", self.latRestarant)
            print("langRestarant ---->> ", self.langRestarant)
            
            self.drawPath(startLocation: CLLocation.init(latitude: self.Latitude.doubleValue!, longitude: self.Longitude.doubleValue!), endLocation: CLLocation.init(latitude: self.latRestarant, longitude: self.langRestarant))
            
            let camera_Angle: GMSCameraPosition = GMSCameraPosition.camera(withLatitude:self.latRestarant, longitude: self.langRestarant, zoom: 14.0)
            
            self.mapview.camera = camera_Angle
            
            
        }, onFail: { err in
            
            print("err in location : ", err)
            
        })
        
        orderBtn.layer.cornerRadius = 5.0
        navigationView.layer.cornerRadius = 25.0
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let lat = 0.0
        let long = 0.0
        let jdgh = CLLocationManager.locationServicesEnabled()
        let kj = CLLocationManager.value(forKeyPath: "lat")
        let juh = CLLocationManager.value(forKeyPath: "long")
        
        let jd = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        print(jd.latitude)
        print(jd.longitude)
        print(lat)
        print(long)
        
        print("Cllocation Coordinate value");
        
    }
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        print("url ===>>>> \(url)")
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = JSON(response.data!)
            let routes = json["routes"].arrayValue
            
            print("routes now  : ", routes)
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 3.0
                polyline.strokeColor = UIColor.red
                polyline.map = self.mapview
                
                let bounds = GMSCoordinateBounds(path: path!)
                self.mapview.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 15.0))
            }
            
        }
    }
    
    @IBAction func ActionNavigate(_ sender: Any)
    {
        print("ActionNavigate")
        
        if UIApplication.shared.canOpenURL(URL.init(string: "comgooglemaps://")!)
        {
            self.latLongRestarant.lattitude = latRestarant.toString()
            self.latLongRestarant.longitude = langRestarant.toString()
            let toOpenUrl = "comgooglemaps://?saddr=&daddr=\(self.latLongRestarant.lattitude),\(self.latLongRestarant.longitude)&directionsmode=driving"
            print("toOpenUrl ---->> \(toOpenUrl)")
            UIApplication.shared.open(URL.init(string: toOpenUrl)!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func ActionPhoneCall(_ sender: Any)
    {
        
        if self.phNoRestarant != "" {
            
            guard let number = URL(string: "telprompt://\(self.phNoRestarant)") else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(number)
            }
        }
        else
        {
            Theme.sharedInstance.showErrorpopup(Msg: "Phone number not available")
            //self.view.makeToast("Phone number not available", duration: 3.0, position: .center)
        }
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DirectionViewController:LocationServiceDelegate
{
    func tracingLocation(_ currentLocation: CLLocation)
    {
        current_Location = currentLocation
        
        Latitude = "\(currentLocation.coordinate.latitude)"
        Longitude = "\(currentLocation.coordinate.longitude)"
        
        print("current_Location : ", Latitude, Longitude)
        
        //        LocationService.sharedInstance.stopUpdatingLocation()
    }
    
    func tracingLocationDidFailWithError(_ error: NSError) {
        
        print("location tracing error : ", error.localizedDescription)
    }
    
    func ChangeStatus(_ Locstatus: CLAuthorizationStatus)
    {
        if(LocationService.sharedInstance.Locstatus == .denied || LocationService.sharedInstance.Locstatus == .restricted)
        {
            let messageToShow = "Please allow location access in Settings"
            
            let alert = UIAlertController(title: "Alert", message: messageToShow, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                
                (UIApplication.shared.delegate as! AppDelegate).setInitialViewController(from: "")
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            //            let NoLocVC = storyboard?.instantiateViewController(withIdentifier:"NoLocVCID" ) as! NoLocVC
            //            self.navigationController?.present(NoLocVC, animated: true, completion: nil)
        }
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
