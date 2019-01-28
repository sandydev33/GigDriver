//
//  DashTableViewCell.swift
//  Gig Exchanges
//
//  Created by khim singh on 20/09/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit

class DashTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var checkOutBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class OrgListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageTickView: UIImageView!
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
}
class DashAppTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    
}
class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
}
class OrganizationTableViewCell: UITableViewCell {
    
}
class DepartmentTableViewCell: UITableViewCell {
    @IBOutlet weak var depNameLabel: UILabel!
    @IBOutlet weak var depParentLabel: UILabel!
}
class ScheduleRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var skillNameLabel: UILabel!
    
}
class ScheduleRequest1TableViewCell: UITableViewCell {
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var skillNameLabel: UILabel!
    @IBOutlet weak var reqStaffLabel: UILabel!
    @IBOutlet weak var reqHoursLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var certficateLabel: UILabel!
}
class LocationHederTableViewCell: UITableViewCell{
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
}
class WorkerLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
}
class StandardTableViewCell: UITableViewCell {
    @IBOutlet weak var shiftNamelabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
}
class Standard1TableViewCell: UITableViewCell {
    @IBOutlet weak var shiftNamelabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
}
class UpscheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var requiredHours: UILabel!
    @IBOutlet weak var noofEmp: UILabel!
     @IBOutlet weak var arrowDtails: UIImageView!
}
class TradeShiftTableViewCell: UITableViewCell {
    @IBOutlet weak var schduleAssig: UILabel!
    @IBOutlet weak var schduleTrade: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
}
