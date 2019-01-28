//
//  EmployeeController.swift
//  Gig Exchanges
//
//  Created by khim singh on 19/09/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import JVFloatLabeledTextField
import CoreLocation
class EmployeeController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CLLocationManagerDelegate {
    @IBOutlet weak var navPickerView: UIView!
    var locationManager:CLLocationManager!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var orgEmailTextField: JVFloatLabeledTextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var userNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var orgNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var addressTextField: JVFloatLabeledTextField!
    @IBOutlet weak var ownerNameTextField: JVFloatLabeledTextField!
    var stateArray:Array<Bool> = Array<Bool>()
    var orgValueCode:Array<Dictionary<String,Any>> = Array<Dictionary<String,Any>>()
    var orgJson:JSON = []
    var industryCode:String = ""
    var orgCode:String = ""
    var selectedValue:Int? = 0
    
    @IBOutlet weak var adminConPwdTextField: JVFloatLabeledTextField!
    @IBOutlet weak var AdminPwdTextField: JVFloatLabeledTextField!
    @IBOutlet weak var adminEmailTextField: JVFloatLabeledTextField!
    @IBOutlet weak var adminUserNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var adminNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var industryTextField: JVFloatLabeledTextField!
    @IBOutlet weak var adminBtnSubmit: UIButton!
    @IBOutlet weak var adminUiview: UIView!
    @IBOutlet weak var scrollingView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var scrollConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var conPwdTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    var lat:Double = 0.0
    var long:Double = 0.0
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var orgTextField: UITextField!
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.industryTextField.isEnabled = false
      self.determineMyCurrentLocation()
      //   self.orgWebServices()
        // Do any additional setup after loading the view.
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        lat = userLocation.coordinate.latitude
        long = userLocation.coordinate.longitude
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        conPwdTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
//        emailTextField.resignFirstResponder()
//        nameTextField.resignFirstResponder()
//        orgTextField.resignFirstResponder()
        return false
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.orgJson.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return self.orgJson[row]["industryName"].stringValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedValue = row
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == ownerNameTextField {
            let aSet = NSCharacterSet(charactersIn:"ABCDEFGHIJKLMONPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return ((string == numberFiltered))
        }
        return true
    }
    @IBAction func backBtn(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func pickerBtn(_ sender: UIButton) {
       
        if self.orgJson.isEmpty == false{
        self.pickerView.reloadAllComponents()
        self.pickerView.isHidden = false
        self.navPickerView.isHidden = false
            self.view.endEditing(true)
        }
    }
    @IBAction func donePicBtn(_ sender: Any) {
        self.industryTextField.text = self.orgJson[selectedValue!]["industryName"].stringValue
        self.industryCode = self.orgJson[selectedValue!]["industryCode"].stringValue
        self.pickerView.isHidden = true
        self.navPickerView.isHidden = true
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.pickerView.isHidden = true
        self.navPickerView.isHidden = true
        self.view.endEditing(true)
    }
    @IBAction func checkBoxBtn(_ sender: UIButton) {
        if checkBox.currentImage == UIImage(named: "Radio_off"){
            self.checkBox.setImage(UIImage(named: "radio_on"), for: .normal)
            self.scrollConstraintHeight.constant = self.scrollingView.frame.height * 0.23
            self.adminUiview.isHidden = true
            self.adminBtnSubmit.isHidden = false
            self.accountLabel.isHidden = false
            self.loginBtn.isHidden = false
        }else {
            self.checkBox.setImage(UIImage(named: "Radio_off"), for: .normal)
            self.scrollConstraintHeight.constant = 560
            self.adminUiview.isHidden = false
            self.adminBtnSubmit.isHidden = true
            self.accountLabel.isHidden = true
            self.loginBtn.isHidden = true
        }
    }

    @IBAction func signUpBtn(_ sender: Any) {
        
        if checkBox.currentImage == UIImage(named: "Radio_off"){
            if (self.ownerNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Owner Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.addressTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Address", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.orgNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Organisation Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if !isValidEmail(testStr: self.orgEmailTextField.text!){
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Valid Organisation Email", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.userNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Organisation UserName", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.pwdTextField.text?.count)! <= 5 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Organisation Password should be minimum 6 characters", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.pwdTextField.text)! != (self.conPwdTextField.text)! {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Organisation Password should be same", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
//            else if (self.industryTextField.text?.count)! <= 0 {
//                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
//                })
//                let alertController = UIAlertController(title: "", message:"Please Choose Industry", preferredStyle: .alert)
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: {
//                })
//            }
            else if (self.adminNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Admin Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.adminUserNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Admin UserName", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if !isValidEmail(testStr: self.adminEmailTextField.text!){
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Valid Admin Email", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.AdminPwdTextField.text?.count)! <= 5 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Admin Password should be minimum 6 characters", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.AdminPwdTextField.text)! != (self.adminConPwdTextField.text)! {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Admin Password should be same", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else{
                let dic = [ "name":self.ownerNameTextField.text!,
                                     "email":self.orgEmailTextField.text!,
                                      "userName":self.userNameTextField.text!,
                                      "password":pwdTextField.text!,
                                      "organizationName":self.orgNameTextField.text!,
                                      "industryCode":"95c01b36-e0b5-4904-be7c-eb551a86e01d",
                                      "timeZoneCode": self.industryCode,
                                      "isAdmin": false,
                                      "isOwner": true,
                                      "lang": long,
                                      "lat": lat
                    ] as [String : Any]
                let dics = [ "email": self.adminEmailTextField.text!,
                             "isAdmin": true,
                             "isOwner": false,
                            "name": self.adminNameTextField.text!,
                            "password": self.AdminPwdTextField.text!,
                            "userName": self.adminUserNameTextField.text!
                    ] as [String : Any]
                
                let  newDic = [dic,dics]
                print(newDic)
                self.registerWebservice(dic: newDic)
            }
        }else {
            if (self.ownerNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Owner Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.addressTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Address", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.orgNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Organisation Name", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if !isValidEmail(testStr: self.orgEmailTextField.text!){
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Valid Organisation Email", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.userNameTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Organisation UserName", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.pwdTextField.text?.count)! <= 5 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Organisation Password should be minimum 6 characters", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else if (self.pwdTextField.text)! != (self.conPwdTextField.text)! {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Organisation Password should be same", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
//            else if (self.industryTextField.text?.count)! <= 0 {
//                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
//                })
//                let alertController = UIAlertController(title: "", message:"Please Select Time Zone", preferredStyle: .alert)
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: {
//                })
//            }
            else{
                let dic = [ "name":self.ownerNameTextField.text!,
                            "email":self.orgEmailTextField.text!,
                            "userName":self.userNameTextField.text!,
                            "password":pwdTextField.text!,
                            "organizationName":self.orgNameTextField.text!,
                            "industryCode":"95c01b36-e0b5-4904-be7c-eb551a86e01d",
                            "timeZoneCode": self.industryCode,
                            "isAdmin": true,
                            "isOwner": true,
                            "lang": long,
                            "lat": lat
                    ] as [String : Any]
                let  newDic = [dic]
                print(newDic)
                self.registerWebservice(dic: newDic)
            }
        }
        
    }
    func orgWebServices(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebService.hitGetService(urlToPass: getAllTimeZoneDetailUrl!) { (data) in
          self.orgJson =  JSON(data)
            if self.orgJson["responsecode"] == 200 {
                self.orgJson = self.orgJson["data"]
                
            }
             MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    func registerWebservice(dic:Any){
        MBProgressHUD.showAdded(to: self.view, animated: true)
                let url = changeContectPostType(url: registerUrl!, dic: dic)
                WebService.hitPostJsonService(request: url) { (data) in
                    let dataJson = JSON(data)
                 print(dataJson[0]["responsecode"])
                    if dataJson[0]["responsecode"] == 200 {
                    let alertController = UIAlertController(title: "", message: dataJson[0]["message"].stringValue, preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: {
                        alertController.dismiss(animated: true, completion: {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let objMainViewController: LoginController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginController
                           self.present(objMainViewController, animated:true, completion:nil)
                            MBProgressHUD.hide(for: self.view, animated: true)
                            //  self.performSegue(withIdentifier: "home", sender: true)
                        })
                    })
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when){
                    }
                    }else if dataJson[0]["responsecode"] == 400 || dataJson [0]["responsecode"] == 401 || dataJson [0]["responsecode"] == 402 || dataJson [0]["responsecode"] == 403 || dataJson [0]["responsecode"] == 404 || dataJson [0]["responsecode"] == 500 || dataJson [0]["responsecode"] == 409  {
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            MBProgressHUD.hide(for: self.view, animated: true)
                        })
                        let alertController = UIAlertController(title: "", message: dataJson[0]["message"].stringValue, preferredStyle: .alert)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: {
                        })
                    }else {
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            MBProgressHUD.hide(for: self.view, animated: true)
                        })
                        let alertController = UIAlertController(title: "", message: "Something Went Wrong. Please Try Again", preferredStyle: .alert)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: {
                        })
                    }
        }
        
        
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

