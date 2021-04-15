//
//  StaffTableViewCell.swift
//  PhongNguyenDucBaiTap
//
//  Created by phongnd on 10/5/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var allView: UIView!
    
    var index = 0
    var editClosure: (() -> Void)?
    var deleteClosure: (() -> Void)?
    var cloneClosure: (() -> Void)?
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func bindData(_ object: StaffObject) {
        self.nameLabel.text = object.name
        self.addressLabel.text = object.address
        self.sexLabel.text = object.isMale ? "Nam" : "Nữ"
        self.positionLabel.text = object.level.map { $0.rawValue }
     }
    
    @IBAction func editAction(_ sender: Any) {
        if let edit = self.editClosure {
            edit()
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if let delete = self.deleteClosure {
            delete()
        }
    }
    
    @IBAction func copyClosure(_ sender: Any) {
        if let copy = self.cloneClosure {
            copy()
        }
    }
    
}
