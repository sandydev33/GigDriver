//
//  WebService.swift
//  SugarBox
//  Created by khim singh on 16/05/17.
//  Copyright © 2017 eSoft. All rights reserved.
//
import Foundation
import Alamofire
import SystemConfiguration
import MBProgressHUD
import SwiftyJSON
class WebService{
    class func hitGetService (urlToPass url:URL, parameterToPass parameter:Any?=nil,responceBlock:@escaping (Any?)->Void){
        if isConnectedToNetwork() {
            Alamofire.request(url, method: .get, parameters: parameter as? Dictionary<String,Any>, encoding: URLEncoding.methodDependent, headers:["Content-Type":"application/json"])
                .responseJSON(completionHandler:{ response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                 // print(response.result.error)
                 // print(response.result.value as Any)
                    if response.result.value != nil {
                        let jsonData = try! JSONSerialization.data(withJSONObject: response.result.value, options: JSONSerialization.WritingOptions.prettyPrinted)
                        responceBlock(jsonData)
                        let statusJson = JSON(jsonData)
                        print(statusJson)
                    }else{
                       responceBlock(nil)
                        let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        })
                        let alertController = UIAlertController(title: "Power Mitra", message:"Something Went Wrong. Please Try Again", preferredStyle: .alert)
                        alertController.addAction(okAction)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
                        })
                    }
                })
                   }
        else{
            print("disConnected")
            let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            })
            let alertController = UIAlertController(title: "No Internet connection", message:"Please ensure you are connected to the Internet", preferredStyle: .alert)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
            })
            responceBlock(nil)
            }
    }
    
    class func hitPostService (urlToPass url:URL!, parameterToPass parameter:Any?=nil,responceBlock:@escaping (Any?)->Void){
        if isConnectedToNetwork() {
            Alamofire.request(url, method: .post, parameters: parameter as? Dictionary<String,Any>, encoding: URLEncoding.methodDependent, headers:nil)
                .responseJSON(completionHandler:{ response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.error as Any)
                    print(response.result.value as Any)
                   // MBProgressHUD.showAdded(to: (UIApplication.shared.keyWindow?.rootViewController?.view)!, animated: true)
                    if response.result.value != nil {
                        let jsonData = try! JSONSerialization.data(withJSONObject: response.result.value, options: JSONSerialization.WritingOptions.prettyPrinted)
                        responceBlock(jsonData)
                        let statusJson = JSON(jsonData)
                        print(statusJson)
                    }else{
                       responceBlock(nil)
                        let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        })
                        let alertController = UIAlertController(title: "Power Mitra", message:"Something Went Wrong. Please Try Again", preferredStyle: .alert)
                        alertController.addAction(okAction)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
                        })
                    }
                })
        }
        else{
            print("disConnected")
            let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            })
            let alertController = UIAlertController(title: "No Internet connection", message:"Please ensure you are connected to the Internet", preferredStyle: .alert)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
            })
            responceBlock(nil)
        }
            }
    class func hitPostJsonService (request req:Any?=nil,responceBlock:@escaping (Any?)->Void){
        if isConnectedToNetwork() {
            Alamofire.request(req as! URLRequestConvertible)
                .responseJSON(completionHandler:{ response in
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    print(response.error as Any)
                    print(response.result.value as Any)
                    if let headers = response.response?.allHeaderFields as? [String: String]{
                       print(headers)
                        UserDefaults.standard.set(headers, forKey: "header")
                    }
                    if response.result.value != nil {
                        let jsonData = try! JSONSerialization.data(withJSONObject: response.result.value, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let json = JSON(jsonData)
                        print(json)
                        responceBlock(jsonData)
                    }else{
                       responceBlock(nil)
                        let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                        })
                        let alertController = UIAlertController(title: "Power Mitra", message:"Something Went Wrong. Please Try Again", preferredStyle: .alert)
                        alertController.addAction(okAction)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
                        })
                    }
                })
        }
        else{
            print("disConnected")
            let okAction=UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            })
            let alertController = UIAlertController(title: "No Internet connection", message:"Please ensure you are connected to the Internet", preferredStyle: .alert)
            alertController.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: {
            })
            responceBlock(nil)
        }
}

}
