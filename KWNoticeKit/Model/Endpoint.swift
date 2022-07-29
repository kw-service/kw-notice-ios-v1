//
//  Endpoint.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation

public struct Endpoint {
    
    public enum `Type`: String {
        case kwHome = "kw-home"
        case swCentral = "sw-central"
    }
    
    // MARK: - Properties
    private static var baseURL: URL {
        return BaseURL.baseURL
    }
    
    // MARK: - Methods
    private init() {}
    
    public static func create(_ type: `Type`) -> URL {
        return baseURL.appendingPathComponent(type.rawValue)
    }
}
