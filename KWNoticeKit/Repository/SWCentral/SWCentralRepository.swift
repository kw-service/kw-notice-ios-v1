//
//  SWCentralRepository.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation
import Combine
import Fuse

public final class SWCentralRepository: SWCentralRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: SWCentralDataStoreProtocol
    private var notices = [SWCentralNotice]()
    
    // MARK: - Methods
    public init(dataStore: SWCentralDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() async throws -> [SWCentralNotice] {
        notices = try await dataStore.fetch()
        return notices.sorted(by: >)
    }
    
    public func search(text: String) -> [SWCentralNotice] {
        if text.isEmpty { return notices }
        
        let fuse = Fuse()
        return fuse
            .search(text.removeSpace(), in: notices.map { $0.title.removeSpace() })
            .map { notices[$0.index] }
    }
}
