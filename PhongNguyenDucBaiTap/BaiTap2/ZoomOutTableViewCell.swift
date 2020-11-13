//
//  ZoomOutTableViewCell.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class ZoomOutTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
