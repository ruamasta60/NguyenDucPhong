//
//  VTCalendarViewDelegate.swift
//  CalendarView
//
//  Created by Trung Nguyen on 11/1/18.
//  Copyright © 2018 Trung Nguyen. All rights reserved.
//

import Foundation
protocol VTCalendarViewDelegate {
    func didAcceptCalendar(_ vtCalendarView: VTCalendarView, selectedDates: VTDate)
}
