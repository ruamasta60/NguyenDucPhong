//
//  VTDate.swift
//  CalendarView
//
//  Created by Trung Nguyen on 11/1/18.
//  Copyright © 2018 Trung Nguyen. All rights reserved.
//

import Foundation
class VTDate {
    var day : Int?
    var month: Int?
    var year: Int?
    
    static func getDaysInMonth(month :  Int, year: Int) -> Int{
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    static func getstartDayofMonth(month: Int, year: Int) -> Int{
        if let getFirstDay = getDayOfWeek("\(year)-\(month)-01"){
            return getFirstDay
        }
        return -1
    }
    
    static func isDayAfter(dayA: VTDate, withDayB: VTDate) -> Bool{
        if dayA.year! < withDayB.year! {
            return true
        }else if dayA.year! > withDayB.year!{
            return false
        }else{
            if dayA.month! < withDayB.month! {
                return true
            }else if dayA.month! > withDayB.month!{
                return false
            }else{
                if dayA.day! < withDayB.day! {
                    return true
                }
            }
        }
        return false
    }
    
    static func sortListVTDate( lstVTDate: [VTDate], isIncrease: Bool) -> [VTDate]{
        var tgList = lstVTDate
        if lstVTDate.count < 2 {
            return lstVTDate
        }
        for i in 0..<tgList.count {
            for j in 0..<(tgList.count){
                if isIncrease{
                    if VTDate.isDayAfter(dayA: tgList[i], withDayB: tgList[j]){
                        tgList.swapAt(i, j)
                    }
                }else{
                    if VTDate.isDayAfter(dayA: tgList[j], withDayB: tgList[i]){
                        tgList.swapAt(i, j)
                    }
                }
            }
        }
        return tgList
    }
    
    static func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    static func getCurrentDay() -> VTDate{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let current = VTDate(day: components.day, month: components.month, year: components.year)
        return current
    }
    
    init(day: Int? = 1, month: Int? = 1, year: Int? = 1994) {
        self.day = day
        self.month = month
        self.year = year
    }
    
}
