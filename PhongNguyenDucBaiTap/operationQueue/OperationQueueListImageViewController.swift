//
//  OperationQueueListImageViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by Phong on 3/12/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import UIKit

class OperationQueueListImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var downloadButton: UIButton!
    
    var listImage = [Photos]()
    var urls = [String]()
    let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        downloadButton.setTitle("download", for: .normal)
        
        self.tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        
        for image in self.listImage {
            urls.append(image.url)
        }
        operationQueue.maxConcurrentOperationCount = 2
    }

    @IBAction func downloadAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            downloadButton.setTitle("Cancel", for: .normal)
            downloadImages()
        } else {
            downloadButton.setTitle("Download", for: .normal)
            operationQueue.cancelAllOperations()
            print("Cancel")
        }

    }
    
    func downloadImages() {
        let finishOperation = BlockOperation {
            print("Finish download")
            DispatchQueue.main.async {
                self.downloadButton.isSelected = false
                self.downloadButton.titleLabel?.text = "Download"
            }
        }
        
        for index in 0..<self.urls.count {
            let blockOpreration = BlockOperation()
            let downloadBlock = self.downloadImage(from: self.urls[index], completion: {_ in
                print("download success")
                blockOpreration.cancel()
                
            })
            blockOpreration.addExecutionBlock {
                print("download start")
                downloadBlock?.resume()
            }
            finishOperation.addDependency(blockOpreration)
            operationQueue.addOperation(blockOpreration)
        }
        operationQueue.addOperation(finishOperation)
    }
    
    func downloadImage(from url: String, completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(data)
        })
        return task
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
        cell.bindDataPhoto(image: image)
        
        return cell
    }
}
