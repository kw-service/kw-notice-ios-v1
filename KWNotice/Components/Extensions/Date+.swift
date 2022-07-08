//
//  Date+.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/08.
//

import Foundation

extension Date {
    func toString(format: String = "YYYY-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.calendar = .autoupdatingCurrent
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
