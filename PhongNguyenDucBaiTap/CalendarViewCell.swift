//
//  CalendarViewCell.swift
//  CalendarView
//
//  Created by Trung Nguyen on 10/31/18.
//  Copyright © 2018 Trung Nguyen. All rights reserved.
//

import UIKit

class CalendarViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNumber: UILabel!
    var isSeletedDate: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblNumber.layer.cornerRadius = lblNumber.frame.height / 2
        lblNumber.clipsToBounds = true
        lblNumber.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
    }
    
    func changeSelected(isSelect : Bool) {
        lblNumber.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        if isSelect {
            lblNumber.backgroundColor = #colorLiteral(red: 0.1058823529, green: 0.4117647059, blue: 0.737254902, alpha: 1)
            lblNumber.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            lblNumber.backgroundColor = UIColor.clear
            lblNumber.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        isSeletedDate = isSelect
    }
}
