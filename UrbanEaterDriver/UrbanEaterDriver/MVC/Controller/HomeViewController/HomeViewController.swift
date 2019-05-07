//
//  HomeViewController.swift
//  DriverReadyToEat
//
//  Created by casperonios on 10/11/17.
//  Copyright © 2017 CasperonTechnologies. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import EZSwiftExtensions

class HomeViewController: UIViewController,GMSMapViewDelegate{
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var slidetoOpenView: ShadowView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lastPaidEarningsLbl: UILabel!
    @IBOutlet weak var supportBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var earningsViewInView: UIView!
    @IBOutlet weak var earningsViewHeight: NSLayoutConstraint!
    
    var currentLocat_Btn:UIButton = UIButton()
    var current_Lat:String!
    var current_Long:String!
    var getLatLong_Add:String = String()
    var myLocation: CLLocation?
    var past7Dates = [String]()
    var past7Days = [String]()
    
    var onlineString:NSAttributedString{
        let attributeString = TheGlobalPoolManager.attributedTextWithTwoDifferentTextsWithFont("Swipe right to come ", attr2Text: "Online", attr1Color: .secondaryTextColor, attr2Color: .textColor, attr1Font: 14, attr2Font: 16, attr1FontName: .Regular, attr2FontName: .Medium)
        return attributeString
    }
    var offlineString:NSAttributedString{
        let attributeString = TheGlobalPoolManager.attributedTextWithTwoDifferentTextsWithFont("Swipe left to go ", attr2Text: "Offline", attr1Color: .secondaryTextColor, attr2Color: .textColor, attr1Font: 14, attr2Font: 16, attr1FontName: .Regular, attr2FontName: .Medium)
        return attributeString
    }
    
    lazy var slideToOpen: SlideToOpenView = {
        let slide = SlideToOpenView(frame: CGRect(x: 0, y: 0, width: ez.screenWidth * 0.8, height: self.slidetoOpenView.frame.size.height))
        slide.sliderViewTopDistance = 0
        slide.textLabelLeadingDistance = 40
        slide.sliderCornerRadious = self.slidetoOpenView.frame.size.height/2.0
        slide.defaultLabelAttributeText = self.onlineString
        slide.thumnailImageView.image = #imageLiteral(resourceName: "offline_switch")
        slide.thumnailImageView.backgroundColor = .clear
        slide.draggedView.backgroundColor = .clear
        slide.draggedView.alpha = 0.8
        slide.delegate = self
        return slide
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "EarningsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EarningsCollectionViewCell")
        collectionView.register(UINib(nibName: "EarningsSeeAllACollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EarningsSeeAllACollectionViewCell")
        self.setupMapView()
        past7Dates = Date.getDates(forLastNDays: 7).0 as [String]
        past7Days  =  Date.getDates(forLastNDays: 7).1 as [String]
    }
    //MARK:- Update UI
    func updateUI(){
        TheGlobalPoolManager.cornerAndBorder(self.earningsViewInView, cornerRadius: 8, borderWidth: 0.5, borderColor: .lightGray)
        TheGlobalPoolManager.cornerRadiusForParticularCornerr(self.earningsViewInView, corners: [.bottomRight,.topRight], size: CGSize(width: 8, height: 0))
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: self.collectionView.frame.height)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        self.slidetoOpenView.addSubview(self.slideToOpen)
        self.slidetoOpenView.layer.cornerRadius = self.slidetoOpenView.frame.size.height/2.0
        self.drivingHomeApiHitting()
    }
    func setupMapView() {
        ModelClassManager.myLocation()
        ModelClassManager.delegate = self
        mapView.delegate = self
        self.updateUI()
    }
    func setMap_View(lat:String,long:String){
        var lati = String()
        var longti = String()
        lati = lat
        longti = long
        let UpdateLoc = CLLocationCoordinate2DMake(CLLocationDegrees(lati)!,CLLocationDegrees(longti)!)
        let camera = GMSCameraPosition.camera(withTarget: UpdateLoc, zoom: 15)
        let userLocationMarker = GMSMarker(position: UpdateLoc)
        userLocationMarker.map = mapView
        mapView.animate(to: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    //MARK : - Driver By ID Api Hitting
    func drivingHomeApiHitting() {
        Theme.sharedInstance.activityView(View: self.view)
        let param = ["id": TheGlobalPoolManager.driverLoginModel.data.subId!]
        
        URLhandler.postUrlSession(urlString: Constants.urls.DriverByID, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.driverHomeModel = DriverHomeModel(fromJson: dataResponse.json)
                let data = TheGlobalPoolManager.driverHomeModel.data
                if data?.available == 0{
                    self.slideToOpen.isFinished = false
                    self.slideToOpen.updateThumbnailViewLeadingPosition(0)
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: false)
                    self.earningsViewHeight.constant = 320
                    self.bottomView.isHidden = false
                    self.supportBtn.isHidden = false
                    self.lastPaidEarningsLbl.isHidden = false
                    ModelClassManager.locationManager.stopUpdatingLocation()
                }else{
                    self.slideToOpen.isFinished = true
                    self.slideToOpen.updateThumbnailViewLeadingPosition(self.slideToOpen.xEndingPoint)
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: true)
                    self.earningsViewHeight.constant = 0
                    self.bottomView.isHidden = true
                    self.supportBtn.isHidden = true
                    self.lastPaidEarningsLbl.isHidden = true
                }
                self.collectionView.reloadData()
            }
        }
    }
    //MARK:- Chnage Driver Status Api
    func changeDriverStatusWebHit(_ status: Int){
        let param = [ "id": TheGlobalPoolManager.driverLoginModel.data.subId!,
                      "available": status] as [String : Any]
        URLhandler.postUrlSession(urlString: Constants.urls.DriverUpdateByID, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            if dataResponse.json.exists(){
                let dict = dataResponse.dictionaryFromJson! as NSDictionary
                Theme.sharedInstance.showErrorpopup(Msg: dict.object(forKey: "message") as! String)
                self.drivingHomeApiHitting()
            }
        }
    }
    //MARK : - Support Button Method
    func supportBtnMethod(){
        let helpVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpSupportViewControllerID") as! HelpSupportViewController
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    //MARK : - Pushing To Your  Earnings View Controller
    func pushingToYourEarningsVC() {
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "YourEarningsViewControllerID") as? YourEarningsViewController{
            self.navigationController?.pushViewController(viewCon, animated: true)
        }
    }
    //MARK:- IB Action Outlets
    @IBAction func supportBtn(_ sender: UIButton) {
        self.supportBtnMethod()
    }
}
extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension HomeViewController : ModelClassManagerDelegate{
    func delegateForLocationUpdate(_ viewCon: SingleTonClass, location: CLLocation) {
        print("Delegate Called IN AddDeliveryLocationVC")
        self.myLocation = location
        if current_Lat == nil && current_Long == nil{
            current_Lat = "\(location.coordinate.latitude)"
            current_Long = "\(location.coordinate.longitude)"
            
            print(current_Lat,current_Long,ModelClassManager.locationManager.desiredAccuracy)
        }
        self.setMap_View(lat: (current_Lat as NSString) as String, long: (current_Long as NSString) as String)
    }
}
extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TheGlobalPoolManager.driverHomeModel == nil ? 0 : TheGlobalPoolManager.driverHomeModel.data.earningIdData.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == TheGlobalPoolManager.driverHomeModel.data.earningIdData.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EarningsSeeAllACollectionViewCell", for: indexPath as IndexPath) as! EarningsSeeAllACollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EarningsCollectionViewCell", for: indexPath as IndexPath) as! EarningsCollectionViewCell
        let data = TheGlobalPoolManager.driverHomeModel.data.earningIdData[indexPath.row]
        let weekday = Date.init(fromString: data.dateString!, format: "yyyy-MM-dd")?.dayOfWeek()!
        cell.dateLbl.text =  "\(weekday!)\n\(TheGlobalPoolManager.convertDateFormater(data.dateString!))"
        cell.ordersLbl.text = data.orderCount.toString
        cell.amountLbl.text = data.earnAmount.toString
        if data.billingStatus! == 0{
            cell.paidStatusLbl.backgroundColor = .themeColor
        }else{
            cell.paidStatusLbl.backgroundColor = .greenColor
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        if indexPath.row == 2{
            self.pushingToYourEarningsVC()
        }
    }
}
extension HomeViewController : SlideToOpenDelegate{
    func SlideToOpenChangeImage(_ slider:SlideToOpenView, switchStatus: Bool){
        if switchStatus {
            print("on---->>>")
            slider.defaultLabelAttributeText = offlineString
            slider.thumnailImageView.image = #imageLiteral(resourceName: "online_switch")
            slider.textLabelLeadingDistance = 0
        }else{
            print("off---->>>")
            slider.defaultLabelAttributeText = onlineString
            slider.thumnailImageView.image = #imageLiteral(resourceName: "offline_switch")
            slider.textLabelLeadingDistance = 40
        }
    }
    func SlideToOpenDelegateDidFinish(_ slider:SlideToOpenView, switchStatus: Bool) {
        var titleText : String = "Are you sure you want to Go"
        if switchStatus {
            titleText = titleText + " Online?"
        }else{
            titleText = titleText + " Offline?"
        }
        TheGlobalPoolManager.showAlertWith(title: "\(titleText)", message: "", singleAction: false, okTitle:"Confirm") { (sucess) in
            if sucess!{
                let data = TheGlobalPoolManager.driverHomeModel.data!
                if data.available == 0{
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: true)
                    self.changeDriverStatusWebHit(1)
                }else{
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: false)
                    self.changeDriverStatusWebHit(0)
                }
            }else{
                if switchStatus{
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: false)
                    self.slideToOpen.updateThumbnailViewLeadingPosition(0)
                    self.slideToOpen.isFinished = false
                }else{
                    self.SlideToOpenChangeImage(self.slideToOpen, switchStatus: true)
                    self.slideToOpen.updateThumbnailViewLeadingPosition(self.slideToOpen.xEndingPoint)
                    self.slideToOpen.isFinished = true
                }
            }
        }
    }
}

