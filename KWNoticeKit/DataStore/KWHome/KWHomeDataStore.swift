//
//  KWHomeDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation

public final class KWHomeDataStore: KWHomeDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func fetch() async throws -> [KWHomeNotice] {
        let url = Endpoint.create(.kwHome)
        
        let response = try await APIRequest.shared.get(url)
        guard let decodedValue = try? JSONDecoder().decode(
            [KWHomeNotice].self,
            from: response
        ) else {
            throw APIError.decodeError
        }
        return decodedValue
    }
}
