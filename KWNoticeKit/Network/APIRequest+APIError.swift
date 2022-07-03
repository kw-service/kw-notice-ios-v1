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
}

public final class APIRequest {
    
    // MARK: - Properties
    public static let shared = APIRequest()
    
    // MARK: - Methods
    private init() {}
    
    public func get(_ url: URL) -> AnyPublisher<Data, Error> {
        print("requesting url: \(url)")
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200..<300).contains(response.statusCode) else {
                    throw APIError.invalidCode(code: response.statusCode)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
}
