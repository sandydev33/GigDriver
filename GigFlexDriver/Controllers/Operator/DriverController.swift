//
//  DriverController.swift
//  GigFlexDriver
//
//  Created by Esoft on 11/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import SDWebImage
class DriverController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileOutBtn: UIButton!
    var listingJson:JSON = []
   
    var stateArray:Array<Bool> = Array<Bool>()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileOutBtn.layer.cornerRadius = self.profileOutBtn.frame.size.width/2
        self.navigationController?.isNavigationBarHidden = true
        
       self.listingService()
        // Do any additional setup after loading the view.
    }
    
    func listingService() {
      
            let url = URL(string: getDriversDetailByOperatorCodeUrl + UserDefaults.standard.string(forKey: "userCode")!)
            self.listPendingWebService(url: url!)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.listingJson.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "driver", for: indexPath) as! DriverTableViewCell
        cell.titleNameLabel.text = self.listingJson[indexPath.row]["name"].stringValue
        cell.emailLabel.text = self.listingJson[indexPath.row]["emailId"].stringValue
        cell.fleetSizeLabel.text = "Fleet Size: " + self.listingJson[indexPath.row]["fleetSize"].stringValue
        cell.imageCellView.sd_setImage(with: URL(string: userProfileIconUrl + self.listingJson[indexPath.row]["driverImage"].stringValue)!, placeholderImage:UIImage(named: "user1"))
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let share = UITableViewRowAction(style: .normal, title: "EDIT") { (action, indexPath) in
//            let objMainViewController: EditViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! EditViewController
//            if self.listingJson[indexPath.row]["worker"].isEmpty == false {
//                objMainViewController.listJson = self.listingJson[indexPath.row]["worker"]
//                self.present(objMainViewController, animated:true, completion:nil)
//            }else if self.listingJson.isEmpty == false{
//                objMainViewController.listJson = self.listingJson
//                self.present(objMainViewController, animated:true, completion:nil)
//            }
        }
      
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            //            let objMainViewController: EditViewController = mainStoryboard.instantiateViewController(withIdentifier: "edit") as! EditViewController
            //            if self.listingJson[indexPath.row]["worker"].isEmpty == false {
            //                objMainViewController.listJson = self.listingJson[indexPath.row]["worker"]
            //                self.present(objMainViewController, animated:true, completion:nil)
            //            }else if self.listingJson.isEmpty == false{
            //                objMainViewController.listJson = self.listingJson
            //                self.present(objMainViewController, animated:true, completion:nil)
            //            }
        }
        share.backgroundColor = UIColor.init(hexString: "0086DE")
        delete.backgroundColor = UIColor.red
        return [delete , share]
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
            self.tableView.reloadData()
        }
    }
    @IBAction func profileBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : PopupController = mainStoryboard.instantiateViewController(withIdentifier: "popup") as! PopupController
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func menuBtn(_ sender: UIButton) {
        onSlideMenuButtonPressed(sender )
    }

}
