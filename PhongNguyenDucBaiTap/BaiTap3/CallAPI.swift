//
//  CallAPI.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 1/18/21.
//  Copyright © 2021 phongnd. All rights reserved.
//

import Foundation

protocol CallAPIDelegate {
    func getListImage(completion: @escaping ([BaiTap3Object]) -> Void)
    func downloadImage(withURL url: String, completion: @escaping (Bool) -> Void)
}

class CallAPI: CallAPIDelegate {
    
    static let shared = CallAPI()
    
    let url = "https://jsonplaceholder.typicode.com/photos"
    var dataTask = URLSessionDataTask()
    
    func getListImage(completion: @escaping ([BaiTap3Object]) -> Void) {
        request(successCompletion: { (response: [BaiTap3Object]) in
            var lst = [BaiTap3Object]()
            for obj in response {
                lst.append(obj)
                if lst.count >= 10 {
                    break
                }
            }
            completion(lst)
        })
    }
    
    func downloadImage(withURL url: String, completion: @escaping (Bool) -> Void) {
        guard let urlImage = URL(string: url) else { return }
        download(urlImage, completion: { isSuccess in
            completion(isSuccess)
        })
    }
    
    func request<T: Codable>(successCompletion: @escaping (T) -> Void,
                             failCompletion: (() -> Void)? = nil) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                print("=========RESPONSE===========")
                print(object)
                successCompletion(object)
            } catch let err {
                print("=========ERROR===========")
                print(err)
                failCompletion?()
            }
        }).resume()
    }
    
    
    func download(_ url: URL, completion: @escaping (Bool) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard data != nil else { return }
            completion(true)
        }).resume()
        
    }
}
