//
//  FilterController.swift
//  GigFlexDriver
//
//  Created by Esoft on 10/12/18.
//  Copyright © 2018 Esoft. All rights reserved.
//

import UIKit

class FilterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
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
