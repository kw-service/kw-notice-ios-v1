//
//  KWHomeRepository.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation
import Combine
import Fuse

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
        return notices.sorted(by: sortByEarlyDate)
    }
    
    public func search(text: String) -> [KWHomeNotice] {
        let fuse = Fuse()
        return fuse
            .search(text.removeSpace(), in: notices.map { $0.title.removeSpace() })
            .map { notices[$0.index] }
            .sorted(by: sortByEarlyDate)
    }
    
    private func sortByEarlyDate(_ lhs: KWHomeNotice, _ rhs: KWHomeNotice) -> Bool {
        return lhs.postedDate < rhs.postedDate
    }
}
