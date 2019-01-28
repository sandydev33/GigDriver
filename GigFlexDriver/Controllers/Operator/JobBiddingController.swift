//
//  JobBiddingController.swift
//  GigFlexDriver
//
//  Created by Esoft on 11/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class JobBiddingController: BaseViewController , UITableViewDelegate,UITableViewDataSource{
@IBOutlet weak var profileOutBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var stateArray:Array<Bool> = Array<Bool>()
    var listingJson:JSON = []
    var page:Int = 0
    var limit:Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
profileOutBtn.layer.cornerRadius = self.profileOutBtn.frame.size.width/2
        // Do any additional setup after loading the view.
        self.hittingService(page: self.page, limit: self.limit)
    }
    
    func hittingService(page:Int , limit:Int) {
        let url = URL(string: getAllValidUnAssignedBookingExceptCreatorByPageUrl + UserDefaults.standard.string(forKey: "organizationCode")! + "?page=" + String(page) + "&count=" + String(limit))
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "bidding1", for: indexPath) as! Bidding1TableViewCell
            cell.titleName.text = self.listingJson[indexPath.row]["organizationName"].stringValue
            cell.pickUpDate.text = self.listingJson[indexPath.row]["pickUpTime"].stringValue
            cell.noPassengers.text = self.listingJson[indexPath.row]["noOfPassengers"].stringValue
            cell.noBaggage.text = self.listingJson[indexPath.row]["noOfBaggage"].stringValue
            cell.customFare.text = self.listingJson[indexPath.row]["customerFare"].stringValue
            cell.orgName.text = self.listingJson[indexPath.row]["organizationName"].stringValue
            cell.paymentOption.text = self.listingJson[indexPath.row]["paymentOption"].stringValue
             cell.additStop.text = self.listingJson[indexPath.row]["additionalStopPage"].stringValue
            cell.addtiComnt.text = self.listingJson[indexPath.row]["additionalComment"].stringValue
            cell.picAdd.text = self.listingJson[indexPath.row]["pickUpAddress"].stringValue
            cell.rideType.text = self.listingJson[indexPath.row]["vehicleName"].stringValue
            cell.dropAdd.text = self.listingJson[indexPath.row]["dropOffAddress"].stringValue
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "bidding", for: indexPath) as! BiddingTableViewCell
            cell.titleName.text = self.listingJson[indexPath.row]["organizationName"].stringValue
            cell.pickUpDate.text = self.listingJson[indexPath.row]["pickUpTime"].stringValue
             cell.picAdd.text = self.listingJson[indexPath.row]["pickUpAddress"].stringValue
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func profileBtn(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popup : PopupController = mainStoryboard.instantiateViewController(withIdentifier: "popup") as! PopupController
        let nav = UINavigationController(rootViewController: popup)
        nav.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(nav, animated: true, completion: nil)
    }

 
    @IBAction func menuBtn(_ sender: UIButton) {
        onSlideMenuButtonPressed(sender )
    }
}
