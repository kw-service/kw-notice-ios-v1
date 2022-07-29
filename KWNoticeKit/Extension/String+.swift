//
//  String+.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/14.
//

import Foundation

public extension String {
    
    func yearMonthDateToDate() -> Date? {
        let base = self + "T12:00:00+09:00"
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: base)
    }
    
    func yearMonthDateTimeToDate() -> Date? {
        let base = self.replacingOccurrences(of: " ", with: "T").appending("+09:00")
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: base)
    }
    
    func removeSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}

public extension Array where Element == String {
    
    func removeSpace() -> [Element] {
        return self.map { $0.removeSpace() }
    }
}
