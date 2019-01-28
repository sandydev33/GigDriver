//
//  BookPopUpController.swift
//  GigFlexDriver
//
//  Created by Esoft on 12/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import  JVFloatLabeledTextField
class BookPopUpController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var selectTextField: JVFloatLabeledTextField!
    @IBOutlet weak var navPickerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    var selectedValue:Int? = 0
    var listingJson:JSON = []
    var bookDetails:JSON = []
    var UIReload:UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectTextField.isEnabled = false
        self.listingService()
self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listingJson.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listingJson[row]["name"].stringValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedValue = row
    }
    
    @IBAction func pickerBtn(_ sender: UIButton) {
        
        if self.listingJson.isEmpty == false || self.listingJson != []{
            self.pickerView.reloadAllComponents()
            self.pickerView.isHidden = false
            self.navPickerView.isHidden = false
            self.view.endEditing(true)
        }
    }
    @IBAction func donePicBtn(_ sender: Any) {
        self.selectTextField.text = self.listingJson[selectedValue!]["name"].stringValue
//        self.industryCode = self.orgJson[selectedValue!]["industryCode"].stringValue
        self.pickerView.isHidden = true
        self.navPickerView.isHidden = true
        
    }
    
    @IBAction func cancelPicBtn(_ sender: Any) {
        self.pickerView.isHidden = true
        self.navPickerView.isHidden = true
        self.view.endEditing(true)
    }
    func listingService() {
        
        let url = URL(string: getDriversDetailByOperatorCodeUrl + UserDefaults.standard.string(forKey: "userCode")!)
        self.listPendingWebService(url: url!)
        
    }
    func listPendingWebService(url:URL) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changeGetContectType(url: url)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            self.listingJson = json["data"]
            print(self.listingJson)
            MBProgressHUD.hide(for: self.view, animated: true)
            self.pickerView.reloadAllComponents()
        }
    }
    @IBAction func submitBtn(_ sender: Any) {
        if (self.selectTextField.text?.count)! <= 0 {
            let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            })
            let alertController = UIAlertController(title: "", message:"Please Select The Driver", preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: {
            })
        }else{
            let dic = ["driverCode":self.listingJson[selectedValue!]["driverCode"].stringValue,
                       "operatorCode":self.bookDetails["operatorCode"].stringValue,
                       "rideCode":self.bookDetails["rideCode"].stringValue
            ]
        
            self.driverAssignWebService(url: assignBookingToDriverUrl!, dic: dic)
        }
    }
    func driverAssignWebService(url:URL,dic:Dictionary<String,Any>) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changeContectPostType(url: url, dic: dic)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            if json["responsecode"] == 200 {

                self.dismiss(animated: true, completion: {
                    self.UIReload?.viewDidLoad()
                })
            }
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    @IBAction func cancelBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
