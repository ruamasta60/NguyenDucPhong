//
//  ZoomInTableViewCell.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class ZoomInTableViewCell: UITableViewCell {
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
