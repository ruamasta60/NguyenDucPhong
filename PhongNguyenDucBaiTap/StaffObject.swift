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

class AlbumObject: Mappable {
    var albums = [Albums]()
    var photos = [Photos]()
    required init?(map: Map) {

       }
    
    func mapping(map: Map) {
        albums <- map["albums"]
        photos <- map["photos"]
    }
}

class Albums: Mappable {
    var id = 0
    var title = ""
    
    required init?(map: Map) {

       }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}

class Photos: Mappable {
    var id = 0
    var title = ""
    var albumId = 0
    var url = ""
    var thumbnailUrl = ""
    
    required init?(map: Map) {

       }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        albumId <- map["albumId"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
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
    
    func clone() -> StaffObject {
        return StaffObject.init(JSON: self.toJSON())!
    }
}

class DayObject: NSObject {
    var day: String?
    var isSelect: Bool?
    
    init(day: String, isSelect: Bool) {
        self.day = day
        self.isSelect = isSelect
    }
}
