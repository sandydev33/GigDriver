//
//  SplashViewController.swift
//  Power Mitra
//
//  Created by khim singh on 28/02/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SplashViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    var timer: Timer!
    var progressCounter:Float = 0
    let duration:Float = 80.0
    var progressIncrement:Float = 0
    @IBOutlet weak var appVersionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationController?.isNavigationBarHidden = true
       // progressBar.setProgress(0, animated: true)
       //  self.actionProgress(cur: current)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.appVersionLabel.text = "App version" + " " + version
        }
        progressIncrement = 1.0/duration
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(self.showProgressmm), userInfo: nil, repeats: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func showProgressmm() {
        if(progressCounter > 1.0){
            timer.invalidate()
            let result = UserDefaults.standard.string(forKey:"loginSession")
                if result != nil {
                     let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    if UserDefaults.standard.string(forKey: "workerType") == "Operator"{
                        let objMainViewController: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "Operator") as! UINavigationController
                        self.present(objMainViewController, animated:true, completion:nil)
                        
                    }else if UserDefaults.standard.string(forKey: "workerType") == "Employee"{
                        let objMainViewController: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "wor") as! UINavigationController
                        self.present(objMainViewController, animated:true, completion:nil)
                    }
                }
                else{
                    self.CallingSplash()
                }
            
        }
        progressBar.progress = progressCounter
        progressCounter = progressCounter + progressIncrement
    }
    func CallingSplash(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objMainViewController: LoginController = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginController
        self.present(objMainViewController, animated:true, completion:nil)
      //  performSegue(withIdentifier: "splash", sender: self)
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
