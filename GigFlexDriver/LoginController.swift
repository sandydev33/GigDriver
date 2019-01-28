//
//  LoginController.swift
//  Dictum
//
//  Created by khim singh on 29/08/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import UserNotifications
import JVFloatLabeledTextField
class LoginController: UIViewController,UITextFieldDelegate ,UNUserNotificationCenterDelegate{

    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var mobileTextField: JVFloatLabeledTextField!
    @IBOutlet weak var pwdTextField: JVFloatLabeledTextField!
    //    @IBOutlet weak var mobileTextField: UITextField!
//    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginViewLine: UIView!
    @IBOutlet weak var pwdViewLine: UIView!
    @IBOutlet weak var loginHeight: NSLayoutConstraint!
    @IBOutlet weak var pwdHeight: NSLayoutConstraint!
    var loginJson:JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        mobileTextField.resignFirstResponder()
        pwdTextField.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        if textField == mobileTextField {
//            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//            let compSepByCharInSet = string.components(separatedBy: aSet)
//            let numberFiltered = compSepByCharInSet.joined(separator: "")
//            return ((string == numberFiltered) && ((textString.count) <= 10))
 //        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileTextField {
            loginHeight.constant = 2
            pwdHeight.constant = 1
        }else if textField == pwdTextField {
            loginHeight.constant = 1
            pwdHeight.constant = 2
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
                loginHeight.constant = 1
                pwdHeight.constant = 1
        }
    }
    func serviceCall(){
        let dic = ["username":self.mobileTextField.text!,
                   "password":self.pwdTextField.text!
                  ]
        self.loginWebService(dic: dic)
    }
    @IBAction func checkActionBtn(_ sender: UIButton) {
        if self.checkBoxBtn.currentImage == UIImage(named: "checkbox") {
            self.checkBoxBtn.setImage(UIImage(named: "checkbox_tick"), for: .normal)
        }else{
             self.checkBoxBtn.setImage(UIImage(named: "checkbox"), for: .normal)
        }
    }
    @IBAction func AllBtns(_ sender: UIButton) {
        switch sender.tag {
        case allBtnsTags.loginBtnTag.rawValue:
            if (self.mobileTextField.text?.count)! <= 0 {
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter UserName", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else if (self.pwdTextField.text?.count)! <= 5{
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                    
                })
                let alertController = UIAlertController(title: "", message:"Password should be minimum 6 characters", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }else{
//                let notificationType = UIApplication.shared.currentUserNotificationSettings?.types
//                if notificationType?.rawValue == 0 {
//                    print("Disabled")
//                    let alertController = UIAlertController(title: "Notification Services Disabled", message: "Please enable Notification services for this app.", preferredStyle: .alert)
//                                                                let OKAction = UIAlertAction(title: "OK", style: .default,
//                                                                                             handler: {(alert) in
//                                                                                                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: {enabled in
//                                                                                                    // ... handle if enabled
//                                                                                                })
//                                                                })
//                                                                alertController.addAction(OKAction)
//                                                                OperationQueue.main.addOperation {
//                                                                    self.present(alertController, animated: true,
//                                                                                 completion:nil)
//                                                                }
//                                                                print("Push not authorized")
//                } else {
//                   //  self.serviceCall()
//                    print("Enabled")
//                }
                self.serviceCall()
            
        }
            break
        case allBtnsTags.forgotBtnTag.rawValue:
            break
        case allBtnsTags.registerBtnTag.rawValue:
            break
        default:
            break
        }
    }
    func loginWebService(dic:Dictionary<String,Any>){
        MBProgressHUD.showAdded(to: self.view, animated: true)
       let url = changeContectPostType(url: loginUrl!, dic: dic)
        WebService.hitPostJsonService(request: url) { (data) in
            let dataJson = JSON(data)
            print(dataJson)
            if dataJson["responsecode"] == 200 {
                        let result = UserDefaults.standard.dictionary(forKey:"header")
                        let headerJson = JSON(result!)
                        UserDefaults.standard.set(headerJson["Authorization"].stringValue, forKey: "loginSession")
                      //  MBProgressHUD.hide(for: self.view, animated: true)
                        let url = URL(string:  getWorkerTypeUrl )
                        self.getWorkerType(url: url!)
                       // self.performSegue(withIdentifier: "home", sender: true)
            }else{
                let loginJson = responceJson(resJson: dataJson, UIController: self)
                print(loginJson)
            }
        }
    }
    func getWorkerType(url:URL ) {
        let url = changeGetContectType(url: url)
       WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
        UserDefaults.standard.set(json["Data"]["UserType"].stringValue, forKey: "workerType")
       
            let url = URL(string:  getUserCodeUrl )
            self.getUserCode(url: url!)
        }
    }
    func getUserCode(url:URL ) {
        let url = changeGetContectType(url: url)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
           
            let alertController = UIAlertController(title: "", message: dataJson["message"].stringValue, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: {
                alertController.dismiss(animated: true, completion: {
                    UserDefaults.standard.set(json["data"]["userName"].stringValue, forKey: "workerName")
                    UserDefaults.standard.set(json["data"]["email"].stringValue, forKey: "email")
                    UserDefaults.standard.set(json["data"]["userCode"].stringValue, forKey: "userCode")
                    UserDefaults.standard.set(json["data"]["organizationlist"][0]["industryCode"].stringValue, forKey: "industryCode")
                    UserDefaults.standard.set(json["data"]["organizationlist"][0]["organizationCode"].stringValue, forKey: "organizationCode")

                    MBProgressHUD.hide(for: self.view, animated: true)
                    if UserDefaults.standard.string(forKey: "workerType")! == "Operator"{
                         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let objMainViewController: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "Operator") as! UINavigationController
                        self.present(objMainViewController, animated:true, completion:nil)
                    }else if UserDefaults.standard.string(forKey: "workerType")! == "Employee"{
                      self.performSegue(withIdentifier: "worker", sender: true)
                    }
                })
            })
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
            }
        }
    }
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 //       if segue.identifier == "home" {
 //           let vc = segue.destination as! HistoryController
 //           vc.loginJson = loginJson
  //      }
  //  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
