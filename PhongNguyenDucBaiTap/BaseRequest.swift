//
//  BaseRequest.swift
//  PhongNguyenDucBaiTap
//
//  Created by phongnd on 10/3/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BaseRequest: NSObject {
    func requestUrl<T: Mappable>(url: String,type: T.Type, completionHandler: @escaping (T) -> Void) {
        AF.request(url, method: .get).responseJSON { (reponse) in
            if let jsonData = reponse.data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any], let obj = T(JSON: json){
                        completionHandler(obj)
                    }
                }catch {}
            }
        }
    }
}
