//
//  ImageCell.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 1/18/21.
//  Copyright © 2021 phongnd. All rights reserved.
//


import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImg: UIImageView!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(image: BaiTap3Object) {
        guard let urlImage = image.url else { return }
        guard let url = URL(string: urlImage) else { return }
//        DispatchQueue.global(qos: .userInitiated).async {
//            let data =  NSData(contentsOf: url)
//            DispatchQueue.main.async {
//                self.thumbnailImg.image = UIImage(data: data! as Data)
//            }
//        }
        albumLabel.text = String(image.albumId ?? 0)
        idLabel.text = String(image.id ?? 0)
        titleLabel.text = image.title
    }
}
