//
//  SWCentralNotice.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation

public struct SWCentralNotice: Decodable {
    public let id: Int
    public let title: String
//    public let postedDate: Date
    public let url: URL
    public let type: String
//    public let crawledTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id, title, url, type
//        case postedDate = "posted_date"
//        case crawledTime = "crawled_time"
    }
}
