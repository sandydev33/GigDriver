//
//  PopupController.swift
//  Gig Exchanges
//
//  Created by khim singh on 29/10/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit

class PopupController: UIViewController {

    @IBOutlet weak var popView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }
    @IBAction func myProfileBtn(_ sender: UIButton) {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let popup : OrganizationEditController = mainStoryboard.instantiateViewController(withIdentifier: "orgEdit") as! OrganizationEditController
//        let nav = UINavigationController(rootViewController: popup)
//
//        self.present(nav, animated: true, completion: nil)

        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objMainViewController: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier: "orgEdit") as! UINavigationController
        self.present(objMainViewController, animated:true, completion:nil)
    }
    @IBAction func inboxBtn(_ sender: UIButton) {
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            UserDefaults.standard.set(nil, forKey: "loginSession")
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let objMainViewController: SplashViewController = mainStoryboard.instantiateViewController(withIdentifier: "splash") as! SplashViewController
            self.present(objMainViewController, animated:true, completion:nil)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (alert) in
           
        })
        let alertController = UIAlertController(title: "", message: "Are you sure want to logout?", preferredStyle: .alert)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: {
        })
       
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
        popView.isHidden = false
      
    }
    @IBAction func cancelBtn(_ sender: Any) {
        removeAnimate()
        self.dismiss(animated: true, completion: nil)
    
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
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
