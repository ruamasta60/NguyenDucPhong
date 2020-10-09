//
//  StaffObject.swift
//  PhongNguyenDucBaiTap
//
//  Created by phongnd on 10/3/20.
//  Copyright © 2020 phongnd. All rights reserved.
//

import UIKit
import ObjectMapper

enum PersonStatus: String {
    case Intern = "Intern"
    case Junior = "Junior"
    case Senior = "Senior"
}

class EmployeeObject: Mappable {
    var employees = [StaffObject]()
    required init?(map: Map) {

       }
    
    func mapping(map: Map) {
        employees <- map["employees"]
    }
}

class StaffObject: NSObject, Mappable {
    var address = ""
    var avatar = ""
    var createdAt = ""
    var level: PersonStatus?
    var dayWorking = 0 {
        didSet {
            if dayWorking < 60 {
                self.level = .Intern
            }else if dayWorking < 200 {
                self.level = .Junior
            }else {
                self.level = .Senior
            }
        }
    }
    var id = 0
    var isMale = false
    var name = ""
    var status = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        avatar <- map["avatar"]
        createdAt <- map["createdAt"]
        dayWorking <- map["dayWorking"]
        id <- map["id"]
        isMale <- map["isMale"]
        name <- map["name"]
        status <- map["status"]
    }
}
