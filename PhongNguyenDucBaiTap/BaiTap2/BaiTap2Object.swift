//
//  BaiTap2Object.swift
//  PhongNguyenDucBaiTap
//
//  Created by TTC Training on 11/10/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import Foundation
import ObjectMapper

class VayNoContainerBO: Mappable {
    var dangChoVayData: [VayNoBO] = []
    var dangVayData: [VayNoBO] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        dangChoVayData <- map["dangChoVay"]
        dangVayData <- map["dangVay"]
    }
}

class VayNoBO: Mappable {
    var opened = false
    var name = ""
    var money = ""
    var content = ""
    var time = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        money <- map["money"]
        content <- map["content"]
        time <- map["time"]
    }
}
