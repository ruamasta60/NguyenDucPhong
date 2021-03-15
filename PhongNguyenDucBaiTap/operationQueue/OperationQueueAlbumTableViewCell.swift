//
//  OperationQueueAlbumTableViewCell.swift
//  PhongNguyenDucBaiTap
//
//  Created by Phong on 3/6/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import UIKit

class OperationQueueAlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
