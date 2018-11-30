
//
//  EditProfileViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 18/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadImgBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var vehicleNoTF: UITextField!
    @IBOutlet weak var licenceTF: UITextField!
    @IBOutlet weak var sumbitBtn: UIButton!
    
    var selectedImage :UIImage!
    var selectedImageBase64String : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    //MARK:- Update UI
    func updateUI(){
        self.nameTF.setBottomBorder()
        self.phoneNumberTF.setBottomBorder()
        self.emailTF.setBottomBorder()
        self.cityTF.setBottomBorder()
        self.vehicleNoTF.setBottomBorder()
        self.licenceTF.setBottomBorder()
        TheGlobalPoolManager.cornerAndBorder(uploadImgBtn, cornerRadius: uploadImgBtn.layer.bounds.h / 2, borderWidth: 0, borderColor: .clear)
        TheGlobalPoolManager.cornerAndBorder(imgView, cornerRadius: imgView.layer.bounds.h / 2, borderWidth: 0, borderColor: .clear)
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
    @IBAction func uploadImgBtn(_ sender: UIButton) {
        self.imagePicking("Upload Photo")
    }
    @IBAction func sumbitBtn(_ sender: UIButton) {
    }
    @IBAction func backBtn(_ sender: UIButton) {
        ez.topMostVC?.popVC()
    }
}
