//
//  BookEditController.swift
//  GigFlexDriver
//
//  Created by Esoft on 12/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField
import MBProgressHUD
import SwiftyJSON

class BookEditController: UIViewController {
@IBOutlet weak var profileOutBtn: UIButton!
    @IBOutlet weak var passNameTextField: JVFloatLabeledTextField!
    @IBOutlet weak var picAddTextField: JVFloatLabeledTextField!
    @IBOutlet weak var picTimeTextField: JVFloatLabeledTextField!
    @IBOutlet weak var dropAddTextField: JVFloatLabeledTextField!
    @IBOutlet weak var noPassTextField: JVFloatLabeledTextField!
    @IBOutlet weak var noBaggTextField: JVFloatLabeledTextField!
    @IBOutlet weak var custFareTextField: JVFloatLabeledTextField!
    @IBOutlet weak var vehicleTextField: JVFloatLabeledTextField!
    @IBOutlet weak var primContTextField: JVFloatLabeledTextField!
    @IBOutlet weak var secContTextField: JVFloatLabeledTextField!
    @IBOutlet weak var addiStopTextField: JVFloatLabeledTextField!
    @IBOutlet weak var payOptionTextField: JVFloatLabeledTextField!
    @IBOutlet weak var addComntTextField: JVFloatLabeledTextField!
    
    @IBOutlet weak var titleName: UILabel!
    var notify:String? = nil
    var editJson:JSON = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileOutBtn.layer.cornerRadius = self.profileOutBtn.frame.size.width/2
        self.navigationController?.isNavigationBarHidden = true
        self.titleName.text = notify
        if notify == "Update Booking"{
            self.passNameTextField.text = self.editJson["passengerName"].stringValue
            self.picAddTextField.text = self.editJson["pickUpAddress"].stringValue
             self.picTimeTextField.text = self.editJson["pickUpTime"].stringValue
            self.dropAddTextField.text = self.editJson["dropOffAddress"].stringValue
            self.noPassTextField.text = self.editJson["noOfPassengers"].stringValue
            self.noBaggTextField.text = self.editJson["noOfBaggage"].stringValue
            self.custFareTextField.text = self.editJson["customerFare"].stringValue
            self.vehicleTextField.text = self.editJson["vehicleName"].stringValue
             self.primContTextField.text = self.editJson["primaryContactNumber"].stringValue
            self.secContTextField.text = self.editJson["secondaryContactNumber"].stringValue
            self.addiStopTextField.text = self.editJson["additionalStopPage"].stringValue
            self.payOptionTextField.text = self.editJson["paymentOption"].stringValue
            self.addComntTextField.text = self.editJson["additionalComment"].stringValue
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitBtn(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func profileBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : PopupController = mainStoryboard.instantiateViewController(withIdentifier: "popup") as! PopupController
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
    }
}
