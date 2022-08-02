//
//  Extension.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/08/02.
//

import Foundation

extension Date{
    static var yesterday: Date { return Date().dayBefore }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: .now)!
    }
}
