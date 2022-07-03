//
//  Random+.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation

extension String {
    static func random(_ length: Int = 10) -> String {
        let lowerPool = "abcdefghijklmnopqrstuvwxyz"
        let pool = lowerPool + lowerPool.uppercased()
        var result = ""
        
        for _ in 0..<length {
            result += String(pool.randomElement()!)
        }
        
        return result
    }
}

extension Date {
    static func random() -> Date {
        let year = Int.random(in: 1970...2023)
        let month = Int.random(in: 1...12)
        let day = Int.random(in: 1...28)
        let component = DateComponents(year: year, month: month, day: day)
        
        return Calendar.current.date(from: component) ?? .now
    }
}
