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
    public let postedDate: Date
    public let modifiedDate: Date
    public let department: String
    public let url: URL
    public let type: String
    public let crawledTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id, title, tag, department, url, type
        case postedDate = "posted_date"
        case modifiedDate = "modified_date"
        case crawledTime = "crawled_time"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.department = try container.decode(String.self, forKey: .department)
        self.url = try container.decode(URL.self, forKey: .url)
        self.type = try container.decode(String.self, forKey: .type)
        
        guard let postedDate = try container
            .decode(String.self, forKey: .postedDate)
            .yearMonthDateToDate() else {
            throw APIError.decodeError
        }
        guard let modifiedDate = try container
            .decode(String.self, forKey: .modifiedDate)
            .yearMonthDateToDate() else {
            throw APIError.decodeError
        }
        guard let crawledTime = try container
            .decode(String.self, forKey: .crawledTime)
            .yearMonthDateTimeToDate() else {
            throw APIError.decodeError
        }
        self.postedDate = postedDate
        self.modifiedDate = modifiedDate
        self.crawledTime = crawledTime
    }
}
