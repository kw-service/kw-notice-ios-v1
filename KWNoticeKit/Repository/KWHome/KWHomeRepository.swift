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
    private let dataStore: KWHomeDataStoreProtocol
    private var notices = [KWHomeNotice]()
    
    // MARK: - Methods
    public init(dataStore: KWHomeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() async throws -> [KWHomeNotice] {
        notices = try await dataStore.fetch()
        return notices
    }
    
    public func search(text: String) -> [KWHomeNotice] {
        if text.isEmpty { return notices }
        else {
            return notices.filter {
                $0.title.lowercased().contains(text.lowercased())
            }
        }
    }
}
