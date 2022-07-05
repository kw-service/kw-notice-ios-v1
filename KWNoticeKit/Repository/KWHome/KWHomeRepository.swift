//
//  KWHomeRepository.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation
import Combine

public final class KWHomeRepository: KWHomeRepositoryProtocol {
    
    // MARK: - Properties
    private var notices = [KWHomeNotice]()
    private let dataStore: KWHomeDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: KWHomeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() async throws -> [KWHomeNotice] {
        throw APIError.invalidResponse
    }
    
    public func search(text: String) -> [KWHomeNotice] {
        return []
    }
}
