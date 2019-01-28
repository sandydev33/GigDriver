//
//  BookingController.swift
//  GigFlexDriver
//
//  Created by Esoft on 11/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
class BookingController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var stateArray:Array<Bool> = Array<Bool>()
    @IBOutlet weak var profileOutBtn: UIButton!
    var page:Int = 0
    var limit:Int = 10
    var listingJson:JSON = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        profileOutBtn.layer.cornerRadius = self.profileOutBtn.frame.size.width/2
        self.hittingService(page: self.page, limit: self.limit)
        // Do any additional setup after loading the view.
    }
    
    func hittingService(page:Int , limit:Int) {
        let url = URL(string: getAllBookingByOperatorCodeWithFilterByPageUrl + UserDefaults.standard.string(forKey: "userCode")! + "/all/2018-01-01/2024-01-01" + "?page=" + String(page) + "&count=" + String(limit))
        self.listUpcomingWebService(url:url!)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listingJson.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.stateArray[indexPath.row]{
            let cell = tableView.dequeueReusableCell(withIdentifier: "book1", for: indexPath) as! Booking1TableViewCell
            cell.titleName.text = self.listingJson[indexPath.row]["passengerName"].string
            cell.driverName.text = self.listingJson[indexPath.row]["driverName"].string
            cell.pickUpAddLabel.text = self.listingJson[indexPath.row]["pickUpAddress"].string
            cell.dropAdd.text = self.listingJson[indexPath.row]["dropOffAddress"].string
            cell.vechileName.text = self.listingJson[indexPath.row]["vehicleName"].string
            cell.pickUpTime.text = self.listingJson[indexPath.row]["pickUpTime"].string
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath) as! BookingTableViewCell
            cell.titleName.text = self.listingJson[indexPath.row]["passengerName"].string
            cell.driverName.text = self.listingJson[indexPath.row]["driverName"].string
            cell.pickUpAddLabel.text = self.listingJson[indexPath.row]["pickUpAddress"].string
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<self.listingJson.count {
            if  indexPath.row == i {
                if self.stateArray[indexPath.row]{
                    self.stateArray [i] = NSNumber(value: false) as! Bool
                }else{
                    self.stateArray [i] = NSNumber(value: true) as! Bool
                }
                
            }else{
                self.stateArray [i] = NSNumber(value: false) as! Bool
            }
        }
        self.tableView.reloadData()
    }
    @IBAction func addDriverBtn(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : BookPopUpController = mainStoryboard.instantiateViewController(withIdentifier: "bookPopup") as! BookPopUpController
        popup.bookDetails = self.listingJson[(indexPath?.row)!]
        popup.UIReload = self
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objMainViewController: BookEditController = mainStoryboard.instantiateViewController(withIdentifier: "bookEdit") as! BookEditController
        objMainViewController.editJson = self.listingJson[(indexPath?.row)!]
        objMainViewController.notify = "Update Booking"
        self.present(objMainViewController, animated:true, completion:nil)
    }
    
    
    func listUpcomingWebService(url:URL) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let url = changeGetContectType(url: url)
        WebService.hitPostJsonService(request: url)  { (data) in
            let dataJson = JSON(data)
            let json = responceJson(resJson: dataJson, UIController: self)
            print(json)
            self.listingJson = json["data"]
            for _ in 0..<self.listingJson.count {
                self.stateArray.append(NSNumber(value: false) as! Bool)
            }
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    @IBAction func createBookBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objMainViewController: BookEditController = mainStoryboard.instantiateViewController(withIdentifier: "bookEdit") as! BookEditController
        objMainViewController.notify = "Create Booking"
        self.present(objMainViewController, animated:true, completion:nil)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : FilterController = mainStoryboard.instantiateViewController(withIdentifier: "filter") as! FilterController
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
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
