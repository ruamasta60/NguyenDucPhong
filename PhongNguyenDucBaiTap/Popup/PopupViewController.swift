//
//  PopupViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by Phong on 4/15/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    var nameStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = nameStr
        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
