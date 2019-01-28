//
//  Global.swift
//  Parking
//
//  Created by khim singh on 30/08/17.
//  Copyright © 2017 eSoft. All rights reserved.
//

import Foundation
import UIKit
import Foundation
import SystemConfiguration.CaptiveNetwork
import SwiftyJSON
import MBProgressHUD
enum allBtnsTags:Int {
    
    
    
    case loginBtnTag = 0
    case forgotBtnTag
    case registerBtnTag
    // ForgotView
    case cancelBtnTag
    case submBtnTag
    case forgotRegisterBtnTag
    // HomeView
    case menuBtnTags
    case lateInBtnTags
    case absentBtnTags
    case selectTimeBtnTags
    case stakeHBtnTags
    case homeSubmitBtnTags
    case cancelHomeBtnTags
    case doneHomeBtnTags
    
    case aboutBtnTag = 100
    case workLoactionBtnTag
    case monFromBtnTag
    case monToBtnTag
    
    case tueFromBtnTag
    case tueToBtnTag
    case wedFromBtnTag
    case wedToBtnTag
    case thusFromBtnTag
    case thusToBtnTag
    case friFromBtnTag
    case friToBtnTag
    case satFromBtnTag
    case satToBtnTag
    case sunFromBtnTag
    case sunToBtnTag
    case orgSubmitBtnTag
    case aboutSubmitBtnTag
    
    // organizationEditView
    
    
}

func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
func changeContentType (url:URL , dic:Dictionary<String,Any>)-> Any{
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try! JSONSerialization.data(withJSONObject: dic)
    return request
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
//    Date().string(format: "EEEE, MMM d, yyyy") // Saturday, Oct 21, 2017
//    Date().string(format: "MM/dd/yyyy")        // 10/21/2017
//    Date().string(format: "MM-dd-yyyy HH:mm")  // 10-21-2017 03:31
//    
//    Date().string(format: "MMM d, h:mm a")     // Oct 21, 3:31 AM
//    Date().string(format: "MMMM yyyy")         // October 2017
//    Date().string(format: "MMM d, yyyy")       // Oct 21, 2017
//    
//    Date().string(format: "E, d MMM yyyy HH:mm:ss Z") // Sat, 21 Oct 2017 03:31:40 +0000
//    Date().string(format: "yyyy-MM-dd'T'HH:mm:ssZ")   // 2017-10-21T03:31:40+0000
//    Date().string(format: "dd.MM.yy")                 // 21.10.17
}

func isConnectedToNetwork() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}
func changeContectType (url:URL , dic:Any) -> Any{
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     request.setValue("7d4004f6-56dc-4f6f-80d4-b25fbe843df7", forHTTPHeaderField: "Access-Token")
    let result = UserDefaults.standard.string(forKey:"loginSession")
    if result != nil {
    request.setValue(UserDefaults.standard.string(forKey: "loginSession")!, forHTTPHeaderField: "Authorization")
    }
    request.httpBody = try! JSONSerialization.data(withJSONObject: dic)
    let json = JSON(try! JSONSerialization.data(withJSONObject: dic))
    print(json)
    return request
}
func changeGetContectType (url:URL ) -> Any{
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(UserDefaults.standard.string(forKey: "loginSession")!, forHTTPHeaderField: "Authorization")
    //request.httpBody = try! JSONSerialization.data(withJSONObject: dic)
    return request
}
func changePutContectType (url:URL , dic:Any ) -> Any{
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(UserDefaults.standard.string(forKey: "loginSession")!, forHTTPHeaderField: "Authorization")
    request.httpBody = try! JSONSerialization.data(withJSONObject: dic)
    return request
}
func changeDELETEContectType (url:URL) -> Any{
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(UserDefaults.standard.string(forKey: "loginSession")!, forHTTPHeaderField: "Authorization")
 //   request.httpBody = try! JSONSerialization.data(withJSONObject: dic)
    return request
}
func milisecondToDate(milisecond:Int)->String{
let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond)/1000)
let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:MM"
let dateStr = dateFormatter.string(from: dateVar)
    return dateStr
}
func milisecondToSeconds(milisecond:Int)->String{
    let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond)/1000)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:MM"
    let dateStr = dateFormatter.string(from: dateVar)
    return dateStr
}
extension UIColor{
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)  
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF)  * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue:      CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

func responceJson(resJson:JSON , UIController:UIViewController) -> JSON {
    var jsonData:JSON = []
    
    if resJson ["responsecode"] == 200{
        jsonData = resJson
        }
        else if resJson ["status"] == 400 || resJson ["status"] == 401 || resJson ["status"] == 402 || resJson ["status"] == 403 || resJson ["status"] == 404 || resJson["status"] == 504 || resJson["status"] == 500 {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
           MBProgressHUD.hide(for: UIController.view, animated: true)
        })
        let alertController = UIAlertController(title: "", message: resJson["message"].stringValue, preferredStyle: .alert)
        alertController.addAction(okAction)
        UIController.present(alertController, animated: true, completion: {
        })
    }
    else if resJson["responsecode"] == 400 || resJson ["responsecode"] == 401 || resJson ["responsecode"] == 402 || resJson ["responsecode"] == 403 || resJson ["responsecode"] == 404 || resJson ["responsecode"] == 500 || resJson ["responsecode"] == 409  {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            MBProgressHUD.hide(for: UIController.view, animated: true)
        })
        let alertController = UIAlertController(title: "", message: resJson["message"].stringValue, preferredStyle: .alert)
        alertController.addAction(okAction)
        UIController.present(alertController, animated: true, completion: {
        })
    }else{
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
          MBProgressHUD.hide(for: UIController.view, animated: true)
        })
        let alertController = UIAlertController(title: "", message: "Something Went Wrong. Please Try Again", preferredStyle: .alert)
        alertController.addAction(okAction)
        UIController.present(alertController, animated: true, completion: {
        })
    }
    return jsonData
}
extension UITableView {
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(_ duration: TimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    func slideInFromRight(_ duration: TimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: CAAnimationDelegate = completionDelegate {
            slideInFromRightTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = kCATransitionPush
        slideInFromRightTransition.subtype = kCATransitionFromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}

