//
//  OrganizationEditController.swift
//  Gig Exchanges
//
//  Created by khim singh on 03/10/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import AVKit
import JVFloatLabeledTextField
import SwiftyJSON
import MBProgressHUD
import Alamofire
import Photos

class OrganizationEditController: BaseViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var listingJson:JSON = []
    var page:Int = 0
    var limit:Int = 10
    var stateArray:Array<Bool> = Array<Bool>()
    var listRow:JSON = []
    @IBOutlet weak var aboutScrollView: UIScrollView!
    @IBOutlet weak var aboutLineView: UIView!
    @IBOutlet weak var workingLocationView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileOutBtn: UIButton!
    @IBOutlet weak var workLineView: UIView!
    @IBOutlet weak var aboutOutBtn: UIButton!
    @IBOutlet weak var workOutBtn: UIButton!
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var x = 1
    @IBOutlet weak var orgTextField: JVFloatLabeledTextField!
    @IBOutlet weak var addLine1TextField: JVFloatLabeledTextField!
    @IBOutlet weak var addLine2TextField: JVFloatLabeledTextField!
    @IBOutlet weak var workFromTextField: JVFloatLabeledTextField!
    @IBOutlet weak var workToTextField: JVFloatLabeledTextField!
    @IBOutlet weak var zipTextField: JVFloatLabeledTextField!
    @IBOutlet weak var cityTextField: JVFloatLabeledTextField!
    @IBOutlet weak var stateTextField: JVFloatLabeledTextField!
    @IBOutlet weak var countryTextField: JVFloatLabeledTextField!
    @IBOutlet weak var regisTextField: JVFloatLabeledTextField!
    @IBOutlet weak var phoneTextField: JVFloatLabeledTextField!
    @IBOutlet weak var taxTextField: JVFloatLabeledTextField!
    var details:JSON = []
    var imageName:String? = nil
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileOutBtn.layer.cornerRadius = self.profileOutBtn.frame.size.width/2
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.callingProfileDetails()
//        let url = URL(string: userProfileIconUrl + UserDefaults.standard.string(forKey:"userProfileIcon")!)
//        let data = try? Data(contentsOf: url!)
//        
//        if let imageData = data {
//             profileOutBtn.setImage(UIImage(data: imageData), for: .normal)
//        }
        self.zipTextField.isEnabled = false
        self.cityTextField.isEnabled = false
        self.stateTextField.isEnabled = false
        self.countryTextField.isEnabled = false
     self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    func callingProfileDetails(){
//        let profileUrl = URL(string: getOrganizationByOrgCodeUrl + UserDefaults.standard.string(forKey: "organizationCode")!)
//        self.getProfileWebService(url: profileUrl!)
    }
    @IBAction func allBtns(_ sender: UIButton) {
        switch sender.tag {
        case allBtnsTags.aboutBtnTag.rawValue:
            if aboutScrollView.isHidden {
                workingLocationView.isHidden = true
                aboutScrollView.isHidden = false
                aboutScrollView.slideInFromRight()
             //   self.aboutLineView.slideInFromRight()
              //  aboutLineView.backgroundColor = UIColor.lightGray
             //   workLineView.backgroundColor = UIColor.white
                aboutOutBtn.slideInFromRight()
                aboutOutBtn.backgroundColor = UIColor.init(hexString: "0086DE")
                aboutOutBtn.setTitleColor(UIColor.white, for: .normal)
                workOutBtn.backgroundColor = UIColor.white
                workOutBtn.setTitleColor(UIColor.black, for: .normal)
                
            }
            
            
            break
        case allBtnsTags.workLoactionBtnTag.rawValue:
            if workingLocationView.isHidden {
            workingLocationView.isHidden = false
            aboutScrollView.isHidden = true
            workingLocationView.slideInFromLeft()
             //  workLineView.slideInFromLeft()
              //  aboutLineView.backgroundColor = UIColor.white
               // workLineView.backgroundColor = UIColor.lightGray
                workOutBtn.slideInFromLeft()
                aboutOutBtn.setTitleColor(UIColor.black, for: .normal)
                aboutOutBtn.backgroundColor = UIColor.white
                workOutBtn.setTitleColor(UIColor.white, for: .normal)
                workOutBtn.backgroundColor = UIColor.init(hexString: "0086DE")
                 self.listingService(limit: limit, page: page)
            }
            break
       
        case allBtnsTags.orgSubmitBtnTag.rawValue:
            break
        case allBtnsTags.aboutSubmitBtnTag.rawValue:
            if (self.orgTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Organization Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.addLine1TextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Address Line 1", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.workFromTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Select Work From", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.workToTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Select Work To", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.regisTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Registration Number", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.phoneTextField.text?.count)! <= 9 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Phone Number", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.taxTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Tax ID", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else {
                let dic = [
                    "address": self.addLine1TextField.text!,
                    "address1": self.addLine2TextField.text!,
                  //  "approvedBy": details["approvedBy"].stringValue,
                    "city": self.cityTextField.text!,
                    "country": self.countryTextField.text!,
                    "industryCode": details["industryCode"].stringValue,
                  //  "ipAddress": details["ipAddress"].stringValue,
                   // "isActive": details["isActive"].stringValue,
                   // "isApproved": details["isApproved"].stringValue,
                   // "isDeleted": details["isDeleted"].stringValue,
                    //"isVerified": details["isVerified"].stringValue,
                    "lang": details["lat"].stringValue,
                    "lat": details["lang"].stringValue,
                    "organizationCode": details["organizationCode"].stringValue,
                    "organizationLogo": self.imageName!,
                    "organizationName": self.orgTextField.text!,
                    "phoneNumber": self.phoneTextField.text!,
                    "regNo": self.regisTextField.text!,
                    "stateProvince": self.stateTextField.text!,
                    "taxId": self.taxTextField.text!,
                   // "timezone": details["timezone"].stringValue,
                    "workFrom": self.workFromTextField.text!,
                    "workTo": self.workToTextField.text!,
                    "zipCode": self.zipTextField.text!
                    ] as [String : Any]
//                let url = URL(string: updateOrganizationUrl + details["id"].stringValue)
//                self.getUpdateProfile(url: url!, dic: dic)
                
            }
            break
        default:
            break
        }
    }
    @IBAction func imageSelectBtn(_ sender: Any) {
        let actionPicker = UIAlertController.init(title: "Photos", message: "", preferredStyle: .actionSheet)
        let action1 = UIAlertAction.init(title: "Camera", style: .default) { (void) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
                
                switch cameraAuthorizationStatus {
                case .denied:
                    
                    
                    
                    let alertController = UIAlertController(title: "Camera access required for capturing photos!", message: "Please allow camera services for this app.", preferredStyle: .alert)
                    alertController.view.layoutIfNeeded()
                    let OKAction = UIAlertAction(title: "OK", style: .default,
                                                 handler: {(alert) in
                                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: {enabled in
                                                        // ... handle if enabled
                                                    })
                    })
                    alertController.addAction(OKAction)
                    OperationQueue.main.addOperation {
                        self.present(alertController, animated: true,
                                     completion:nil)
                    }
                    
                    break
                case .authorized:
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.allowsEditing = false
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                    break
                case .restricted:
                    
                    
                    
                    let alertController = UIAlertController(title: "Camera access required for capturing photos!", message: "Please allow camera services for this app.", preferredStyle: .alert)
                    alertController.view.layoutIfNeeded()
                    let OKAction = UIAlertAction(title: "OK", style: .default,
                                                 handler: {(alert) in
                                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: {enabled in
                                                        // ... handle if enabled
                                                    })
                    })
                    alertController.addAction(OKAction)
                    OperationQueue.main.addOperation {
                        self.present(alertController, animated: true,
                                     completion:nil)
                    }
                    break
                    
                case .notDetermined:
                    // Prompting user for the permission to use the camera.
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        if granted {
                            self.imagePicker.sourceType = .camera
                            self.imagePicker.allowsEditing = false
                            self.imagePicker.delegate = self
                            self.present(self.imagePicker, animated: true, completion: nil)
                            print("Granted access to ")
                        } else {
                            print("Denied access to ")
                        }
                    }
                }
                
            }
        }
            let action2 = UIAlertAction.init(title: "Photo Library", style: .default) { (void) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = false
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
            actionPicker.addAction(action1)
            actionPicker.addAction(action2)
            actionPicker.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionPicker, animated: true, completion: nil)
        
    }
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                self.profileImage.image = pickedImage
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                    let assetResources = PHAssetResource.assetResources(for: asset)
                    print(assetResources.first!.originalFilename)
                    
                   
                    if let imageData = pickedImage.jpegData(compressionQuality: 80) {
                        requestWith(imageData: imageData, parameters: ["filename" : assetResources.first!.originalFilename])
                    }
                }else{
                    self.saveImage(imageName: self.details["id"].stringValue, pickedImage: pickedImage)
                }
               
            }
            dismiss(animated: true, completion: nil)
       
        
    }
    func saveImage(imageName: String, pickedImage:UIImage){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = try! fileManager.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = self.profileImage.image!
        //get the PNG data for this image
        let data = image.pngData()
        //store it in the document directory
        fileManager.createFile(atPath: imagePath.absoluteString as String, contents: data, attributes: nil)
        
        if let imageData = pickedImage.jpegData(compressionQuality: 80) {
            requestWith(imageData: imageData, parameters: ["filename" : imagePath.absoluteString])
        }
        
    }
    func getImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            print()
           // self.profileImage.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("Panic! No Image!")
        }
    }
    func requestWith(imageData: Data?, parameters: [String : Any]){
       
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
            "Authorization": UserDefaults.standard.string(forKey: "loginSession")!
            
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "file", fileName: "image.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: uploadFileUrl!, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded", response.result)
                   let json = JSON(response.data)
                    print(json)
                    self.imageName = json["filename"].stringValue
                    print(self.imageName)
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("User canceled image")
        dismiss(animated: true, completion: {
            // Anything you want to happen when the user selects cancel
        })
    }
    func listingService(limit:Int , page:Int) {
        if UserDefaults.standard.string(forKey: "workerType") == "Owner"{
//            let url = URL(string: getOrganizationWorkingLocationHoursByOrgCodeByPageUrl + UserDefaults.standard.string(forKey: "organizationCode")! + "?page=" + String(page) + "&limit=" + String(limit))
//            self.listDepWebService(url: url!)
        }else if UserDefaults.standard.string(forKey: "workerType") == "Employee"{
//            let url = URL(string: workerListUrl + UserDefaults.standard.string(forKey: "userCode")!)
//            self.listDepWebService(url: url!)
        }
        
    }
    
    
    //table View Section
   
    func listDepWebService(url:URL) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changeGetContectType(url: url)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            if UserDefaults.standard.string(forKey: "workerType") == "Owner"{
                self.listingJson = json["data"]
                for _ in 0..<self.listingJson.count {
                    self.stateArray.append(NSNumber(value: false) as! Bool)
                }
            }else if UserDefaults.standard.string(forKey: "workerType") == "Employee"{
                self.listingJson = json["data"]
            }
            
            print(self.listingJson)
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getProfileWebService(url:URL) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changeGetContectType(url: url)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            self.updateProfile(getData: json)
            MBProgressHUD.hide(for: self.view, animated: true)
           
        }
    }
    func updateProfile(getData:JSON){
        let url = URL(string: userProfileIconUrl + getData["data"]["organizationLogo"].stringValue)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            profileImage.image = UIImage(data: imageData)
        }
        self.titleLabel.text = getData["data"]["organizationName"].stringValue
        self.orgTextField.text = getData["data"]["organizationName"].stringValue
        self.addLine1TextField.text = getData["data"]["address"].stringValue
        self.addLine2TextField.text = getData["data"]["address1"].stringValue
        self.workFromTextField.text = getData["data"]["workFrom"].stringValue
        self.workToTextField.text = getData["data"]["workTo"].stringValue
        self.zipTextField.text = getData["data"]["zipCode"].stringValue
        self.cityTextField.text = getData["data"]["city"].stringValue
         self.stateTextField.text = getData["data"]["stateProvince"].stringValue
         self.countryTextField.text = getData["data"]["country"].stringValue
         self.regisTextField.text = getData["data"]["regNo"].stringValue
         self.phoneTextField.text = getData["data"]["phoneNumber"].stringValue
        self.taxTextField.text = getData["data"]["taxId"].stringValue
        details = getData["data"]
    }
    func getUpdateProfile(url:URL , dic:Dictionary<String,Any>) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changePutContectType(url: url, dic: dic)
            WebService.hitPostJsonService(request: url)  { (data) in
                let dataJson = JSON(data)
                let json = responceJson(resJson: dataJson, UIController: self)
                print(json)
                self.updateProfile(getData: json)
                MBProgressHUD.hide(for: self.view, animated: true)
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    
                })
                let alertController = UIAlertController(title: "", message:json["message"].stringValue, preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
                
    }
    }
    @IBAction func profileBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : PopupController = mainStoryboard.instantiateViewController(withIdentifier: "popup") as! PopupController
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
        
        
        //         let objMainViewController: PopupController = mainStoryboard.instantiateViewController(withIdentifier: "popup") as! PopupController
        //        self.present(objMainViewController, animated:true, completion:nil)
    }
    @IBAction func menuBtn(_ sender: UIButton) {
        onSlideMenuButtonPressed(sender)
    }
}
