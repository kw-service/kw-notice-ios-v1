//
//  APIRequest.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation
import Combine

public enum APIError: Error {
    case invalidResponse
    case invalidCode(code: Int)
    case decodeError
}

public final class APIRequest {
    
    // MARK: - Properties
    public static let shared = APIRequest()
    
    // MARK: - Methods
    private init() {}
    
    public func get(_ url: URL) async throws -> Data {
        print("requesting url: \(url)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard (200..<300).contains(response.statusCode) else {
                throw APIError.invalidCode(code: response.statusCode)
            }
            return data
        } catch {
            throw APIError.invalidResponse
        }
    }
}
