//
//  BaiTap3ViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 1/18/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import UIKit

class BaiTap3ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let baseRequest = BaseRequest()
    var listImage = [BaiTap3Object]()
    var urls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        CallAPI.shared.getListImage(completion: { [weak self] listImage in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.listImage = listImage
                weakSelf.tableView.reloadData()
                weakSelf.getListURL()
                self?.dismiss(animated: true, completion: nil)
            }
        })
    }

    func getListURL() {
        for image in self.listImage {
            urls.append(image.url ?? "")
        }
    }
    
    @IBAction func downloadImage(_ sender: UIButton) {
        downloadImages()
    }
    
    func downloadImages() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .utility)
        let semaphore = DispatchSemaphore(value: 2)
        
        for index in 0..<urls.count {
            group.enter()
            semaphore.wait()
            
            queue.async() {
                                
                Thread.sleep(forTimeInterval: 1)
                print("--------------------")
                guard let url = URL(string: self.urls[index]) else { return }
                CallAPI.shared.download(url, completion: { status in
                    if status {
                        print("DOWNLOADED IMAGE \(index + 1)")
                    } else {
                        print("FAIL IMAGE \(index + 1)")
                    }
                    semaphore.signal()
                    group.leave()
                })
            }
        }
        
        group.notify(queue: .main) {
            print("DOWNLOAD COMPLETE")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let image = listImage[indexPath.row]
        cell.bindData(image: image)
        
        return cell
    }

}
