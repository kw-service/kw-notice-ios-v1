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
    private static let baseURL = URL(
        string: "https://n6f11u33jf.execute-api.ap-northeast-2.amazonaws.com/v1"
    )!
    
    // MARK: - Methods
    private init() {}
    
    public static func create(_ type: `Type`) -> URL {
        return baseURL.appendingPathComponent(type.rawValue)
    }
}
