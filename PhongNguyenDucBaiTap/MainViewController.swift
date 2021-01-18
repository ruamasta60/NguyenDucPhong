//
//  MainViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "Bài tập đào tạo"
    }
    @IBAction func bt1action(_ sender: Any) {        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func bt2action(_ sender: Any) {
        let vc2 = BaiTap2ViewController.init(nibName: "BaiTap2ViewController", bundle: nil)
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    @IBAction func bt3Action(_ sender: Any) {
        let vc3 = BaiTap3ViewController.init(nibName: "BaiTap3ViewController", bundle: nil)
        self.navigationController?.pushViewController(vc3, animated: true)
    }
}
