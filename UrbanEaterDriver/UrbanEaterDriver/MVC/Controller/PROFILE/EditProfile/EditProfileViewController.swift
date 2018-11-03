
//
//  EditProfileViewController.swift
//  DriverReadyToEat
//
//  Created by Nagaraju on 18/10/18.
//  Copyright © 2018 CasperonTechnologies. All rights reserved.
//

import UIKit


class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate {

    @IBOutlet weak var scrollviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var arrow : UIImageView!
    @IBOutlet weak var bankInfoBtn: UIButton!
    @IBOutlet var profileImg_View: UIImageView!
    @IBOutlet weak var profileImageBtn: UIButton!
    let commonUtlity : Utilities = Utilities()
    var driver_id = ""
    var picker = UIImagePickerController()
    var popover:UIPopoverController?=nil
    var imagedata: Data = Data()
    
    var iSbankInfoEnabled = false
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImg_View.layer.cornerRadius = 40.0
        profileImg_View.layer.masksToBounds = true
        self.profileImg_View.image = #imageLiteral(resourceName: "iconProfile")
                
        // Do any additional setup after loading the view.
        bankInfoBtn.layer.borderWidth = 1.0
        bankInfoBtn.layer.cornerRadius = 2.0
        bankInfoBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        bankInfoBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.7350973887)
        
    }
    
    @IBAction func editProfileImgBtn_Action(_ sender: UIButton)
    {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            
            UIAlertAction in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
            
        }
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: alert)
            popover!.present(from: profileImg_View.frame, in: self.view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
        }
        //
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            
            if (self.navigationController?.visibleViewController) != nil{
                
                self.present(picker, animated: true, completion: nil)
            }
        }
        else
        {
            openGallary()
        }
    }
    
    func openGallary()
    {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(picker, animated: false, completion: nil)
        

        
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
