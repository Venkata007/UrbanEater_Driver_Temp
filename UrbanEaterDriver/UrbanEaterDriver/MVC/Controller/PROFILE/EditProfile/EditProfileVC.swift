//
//  EditProfileVC.swift
//  UrbanEaterDriver
//
//  Created by Venkat@Hexadots on 30/11/18.
//  Copyright © 2018 Nagaraju. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SDWebImage

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uploadImgBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    var selectedImage :UIImage!
    var selectedImageBase64String : String = ""
    
    let itemsHeaderArray = ["Name *","MobileNumber *","Email *","City *","Vehicle Type *","Driving Licence *"]
    var itemsArray = [String]()
    
    @IBOutlet weak var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        TheGlobalPoolManager.cornerAndBorder(imgView, cornerRadius: imgView.layer.bounds.h / 2, borderWidth: 0, borderColor: .clear)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        if TheGlobalPoolManager.driverHomeModel != nil{
            let data = TheGlobalPoolManager.driverHomeModel.data
            itemsArray = [data?.name!,data?.mobileId!,data?.emailId!,data?.cityName!,data?.vehicleType!,data?.licence.number] as! [String]
            let url = URL.init(string: Constants.BASEURL_IMAGE + (data?.avatar!)!)
            imgView.sd_setImage(with: url ,placeholderImage:  #imageLiteral(resourceName: "Head")) { (image, error, cache, url) in
                if error != nil{
                }else{
                    self.imgView.image = image
                }
            }
        }
    }
    //MARK: - Pushing to Login
    func pushToLoginViewController(){
        if let viewCon = self.storyboard?.instantiateViewController(withIdentifier: "CustomLoginNavigationVCID"){
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window!.rootViewController = viewCon
        }
    }
    func LogOut(){
        TheGlobalPoolManager.showAlertWith(title: "Are you sure", message: "Do you want to logout?", singleAction: false, okTitle:"Confirm") { (sucess) in
            if sucess!{
                TheGlobalPoolManager.logout()
                self.pushToLoginViewController()
            }
        }
    }
    //MARK:- Update Profile Details API Hitting
    func updateProfileDetailsAPIcall(){
        if TheGlobalPoolManager.driverLoginModel == nil{
            self.LogOut()
            return
        }
        Theme.sharedInstance.activityView(View: self.view)
        var param = [
            "id": TheGlobalPoolManager.driverLoginModel.data.subId!,
            "licence": ["number": "123123"]
            ] as [String : Any]
        
        for index in 0..<self.itemsArray.count{
            if let cell = self.tableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as? ItemsCell{
                switch index {
                case 0:
                    if cell.itemTF.text != nil{
                        param["name"] = cell.itemTF.text! as AnyObject
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: "Invalid Name")
                        return
                    }
                case 2:
                    if cell.itemTF.text != nil{
                        param["emailId"] = cell.itemTF.text! as AnyObject
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: "Invalid Email")
                        return
                    }
                case 4:
                    if cell.itemTF.text != nil{
                        param["vehicleType"] = cell.itemTF.text! as AnyObject
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: "Invalid Vehicle Type")
                        return
                    }
                case 5:
                    if cell.itemTF.text != nil{
                        param["licence"] = ["number" : cell.itemTF.text!] as AnyObject
                    }else{
                        URLhandler.sharedInstance.topMostVC()?.view.makeToast(message: "Invalid Licence Number")
                        return
                    }
                default:
                    break
                }
            }
        }
        print(param)
        URLhandler.postUrlSession(urlString: Constants.urls.DriverUpdateByID, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                let dict = dataResponse.dictionaryFromJson! as NSDictionary
                Theme.sharedInstance.showErrorpopup(Msg: dict.object(forKey: "message") as! String)
                self.drivingHomeApiHitting()
            }
        }
    }
    //MARK : - Driver By ID Api Hitting
    func drivingHomeApiHitting() {
        Theme.sharedInstance.activityView(View: self.view)
        let param = ["id": TheGlobalPoolManager.driverLoginModel.data.subId!]
        URLhandler.postUrlSession(urlString: Constants.urls.DriverByID, params: param as [String : AnyObject], header: [:]) { (dataResponse) in
            Theme.sharedInstance.removeActivityView(View: self.view)
            if dataResponse.json.exists(){
                TheGlobalPoolManager.driverHomeModel = DriverHomeModel(fromJson: dataResponse.json)
                self.updateUI()
            }
        }
    }
    //MARK: - Image Picking
    func imagePicking(_ title:String){
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("IPAD")
        }
        else if UIDevice.current.userInterfaceIdiom == .phone{
            let actionSheetController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
            
            let cameraActionButton = UIAlertAction(title: "Take a picture", style: .default) { action -> Void in
                self.imagePicker(clickedButtonat: 0)
            }
            let photoAlbumActionButton = UIAlertAction(title: "Camera roll", style: .default) { action -> Void in
                self.imagePicker(clickedButtonat: 1)
            }
            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            actionSheetController.addAction(cameraActionButton)
            actionSheetController.addAction(photoAlbumActionButton)
            actionSheetController.addAction(cancelActionButton)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
    // MARK: - Image picker from gallery and camera
    private func imagePicker(clickedButtonat buttonIndex: Int) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        switch buttonIndex {
        case 0:
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = .camera
                present(picker, animated: true, completion: nil)
            }
            else{
                print("Camera not available....")
            }
        case 1:
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion:nil)
        default:
            break
        }
    }
    // MARK: - UIImagePickerController delegate methods
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = image
        } else{
            print("Something went wrong")
        }
        convertImage(image: selectedImage)
        print(selectedImage)
        imgView.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func convertImage(image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.1)! as NSData
        let dataString = imageData.base64EncodedString()
        selectedImageBase64String = dataString
        print(" *************** Base 64 String =========\(selectedImageBase64String)")
    }
    //MARK:- IB Action Outlets
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
    @IBAction func submitBtn(_ sender: UIButton) {
        self.updateProfileDetailsAPIcall()
    }
    @IBAction func uploadImgBtn(_ sender: UIButton) {
        self.imagePicking("Upload Photo")
    }
}
//MARK:- UI Table View Cell Class
class ItemsCell : UITableViewCell{
    @IBOutlet weak var itemTF: UITextField!
    @IBOutlet weak var headerLbl: UILabel!
}
// MARK:- UI Table View Delegates and Data Sources
extension EditProfileVC  : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemsHeaderArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell : ItemsCell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell") as! ItemsCell
        cell.headerLbl.text = itemsHeaderArray[indexPath.row]
        cell.itemTF.attributedPlaceholder = NSAttributedString(string: "Enter \(itemsHeaderArray[indexPath.row].replacingOccurrences(of: " *", with: ""))", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        cell.itemTF.text = itemsArray[indexPath.row]
        cell.itemTF.setBottomBorder()
        tableView.separatorStyle = .none
        return  cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
