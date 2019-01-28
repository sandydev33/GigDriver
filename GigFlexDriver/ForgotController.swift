//
//  ForgotController.swift
//  Dictum
//
//  Created by khim singh on 30/08/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import JVFloatLabeledTextField
class ForgotController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var mobileTextField: JVFloatLabeledTextField!
    //  @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileHeight: NSLayoutConstraint!
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
            mobileHeight.constant = 2
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        mobileHeight.constant = 1
    }
    @IBAction func allBtns(_ sender: UIButton) {
        switch sender.tag {
        case allBtnsTags.submBtnTag.rawValue:
            if !isValidEmail(testStr: self.mobileTextField.text!){
                let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                })
                let alertController = UIAlertController(title: "", message:"Please Enter Valid Email", preferredStyle: .alert)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                })
            }
            else{
               
                self.forgotWebservice(dic: self.mobileTextField.text!)
            }
            break
        case allBtnsTags.cancelBtnTag.rawValue:
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            break
        case allBtnsTags.forgotRegisterBtnTag.rawValue:
            
            break
        default:
            break
        }
    }
    
    func forgotWebservice(dic:Any) {
        let url = URL(string: forgotUrl + mobileTextField.text!)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        WebService.hitGetService(urlToPass: url!) { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                 self.performSegue(withIdentifier: "verification", sender: self)
                MBProgressHUD.hide(for: self.view, animated: true)
            })
            let alertController = UIAlertController(title: "", message: json["message"].stringValue, preferredStyle: .alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: {
            })
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verification"{
            let vc = segue.destination as! LoginController
           // vc.mobileNoStr = self.mobileTextField.text!
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
