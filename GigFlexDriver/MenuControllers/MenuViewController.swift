//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//


import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    /**
    *  Array to display menu options
    */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
 //   var arrayMenuOptions = [Dictionary<String>]()
    var arrayMenuOption:Array<String> = Array<String>()
    var imageArry:Array<String> = Array<String>()
    var stateArray:Array<Bool> = Array<Bool>()
    var valu:Int? = nil
   
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    func updateArrayMenuOptions(){
        
        if UserDefaults.standard.string(forKey: "workerType") == "Owner"{
            arrayMenuOption = ["Dashboard","Workers","Standard Shifts","Department","Schedule Request","Skills"]
           
        }else if UserDefaults.standard.string(forKey: "workerType") == "Employee"{
          arrayMenuOption = ["Dashboard","Organisation","Logout"]
        }
        tblMenuOptions.reloadData()
    }
    @IBAction func onCloseMenuClick(_ button:UIButton!){
         
        btnMenu.tag = 6
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileTableViewCell
            cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width/2

            let url = URL(string: userProfileIconUrl + UserDefaults.standard.string(forKey:"userProfileIcon")!)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                cell.profileImage.image = UIImage(data: imageData)
            }
        //    cell.profileImage.image = UIImage(contentsOfFile: profileUrl )
        cell.nameLabel.text = UserDefaults.standard.string(forKey:"workerName")!
        cell.emailLabel.text = UserDefaults.standard.string(forKey:"email")!
        return cell
        }else{
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
            
//        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
//        imgIcon.image = UIImage(named: imageArry[indexPath.row])
        lblTitle.text = arrayMenuOption[indexPath.row]
//            if stateArray[indexPath.row] {
//                lblTitle.textColor = UIColor.blue
//            }else{
//                lblTitle.textColor = UIColor.white
//            }
        return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{}else{
            
//            for i in 0..<self.arrayMenuOption.count {
//                if i == indexPath.row{
//                self.stateArray.append(NSNumber(value: true) as! Bool)
//                }else {
//                    self.stateArray.append(NSNumber(value: false) as! Bool)
//                }
//            }
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        let lblTitle : UILabel = cell!.contentView.viewWithTag(101) as! UILabel
        lblTitle.tag = indexPath.row
        lblTitle.textColor = UIColor.blue
        self.onCloseMenuClick(btn)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
        return arrayMenuOption.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}
