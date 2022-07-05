//
//  SWCentralDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation

public final class SWCentralDataStore: SWCentralDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func fetch() async throws -> [SWCentralNotice] {
        let url = Endpoint.create(.swCentral)
        
        let response = try await APIRequest.shared.get(url)
        guard let decodedValue = try? JSONDecoder().decode(
            [SWCentralNotice].self,
            from: response
        ) else {
            throw APIError.decodeError
        }
        return decodedValue
    }
}
