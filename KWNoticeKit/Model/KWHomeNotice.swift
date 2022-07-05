//
//  KWHomeNotice.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation

public struct KWHomeNotice: Identifiable, Decodable {
    public let id: Int
    public let title: String
    public let tag: String
//    public let postedDate: Date
//    public let modifiedDate: Date
    public let department: String
    public let url: URL
    public let type: String
//    public let crawledTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id, title, tag, department, url, type
//        case postedDate = "posted_date"
//        case modifiedDate = "modified_date"
//        case crawledTime = "crawled_time"
    }
}
