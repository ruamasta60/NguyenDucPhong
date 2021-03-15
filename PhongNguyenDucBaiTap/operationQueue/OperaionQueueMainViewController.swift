//
//  OperaionQueueMainViewController.swift
//  PhongNguyenDucBaiTap
//
//  Created by Phong on 3/6/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import UIKit
enum Operation {
    case A
    case B
}
class OperaionQueueMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseRequest = BaseRequest()
    var checkOperation = Operation.A
    var listAlbums = [Albums]()
    var listPhoto = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "OperationQueueAlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "OperationQueueAlbumTableViewCell")
        self.initData()
    }
    
    func initData() {
        if checkOperation == .B {
            let operation = OperationQueue()
            
            let block1 = BlockOperation {
                self.baseRequest.requestUrl(url: "https://my-json-server.typicode.com/congeovi/albums/db",
                                            type: AlbumObject.self) { (array) in
                                                self.listAlbums = array.albums
                                                self.tableView.reloadData()
                }
            }
            
            let block2 = BlockOperation {
                self.baseRequest.requestUrl(url: "https://my-json-server.typicode.com/congeovi/photos/db",
                                            type: AlbumObject.self) { (array) in
                                                self.listPhoto = array.photos
                }
            }
            block1.addDependency(block2)
            operation.addOperation(block1)
            operation.addOperation(block2)
        } else {
            let operationQueue = OperationQueue()
            let block1 = BlockOperation()
            let block2 = BlockOperation()
            block1.addExecutionBlock {
                self.baseRequest.requestUrl(url: "https://my-json-server.typicode.com/congeovi/albums/db",
                                            type: AlbumObject.self) { (array) in
                                                self.listAlbums = array.albums
                                                self.tableView.reloadData()
                }
            }
            block2.addExecutionBlock {
                self.baseRequest.requestUrl(url: "https://my-json-server.typicode.com/congeovi/photos/db",
                                            type: AlbumObject.self) { (array) in
                                                self.listPhoto = array.photos
                }
            }
            let block3 = BlockOperation {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            block3.addDependency(block1)
            block3.addDependency(block2)
            operationQueue.addOperations([block1, block2, block3], waitUntilFinished: false)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationQueueAlbumTableViewCell") as! OperationQueueAlbumTableViewCell
        let album = listAlbums[indexPath.row]
        cell.id.text = "\(self.listAlbums[indexPath.row].id) Number image in album: \(self.listPhoto.filter({ $0.albumId == album.id }).count)"
        cell.title.text = self.listAlbums[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let operationVC = OperationQueueListImageViewController.init(nibName: "OperationQueueListImageViewController", bundle: nil)
        let album = listAlbums[indexPath.row]
        let list = listPhoto.filter({ $0.albumId == album.id })
        operationVC.listImage = list
        self.navigationController?.pushViewController(operationVC, animated: true)
    }
}
