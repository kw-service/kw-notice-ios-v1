//
//  SWCentralRepository.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation
import Combine

public final class SWCentralRepository: SWCentralRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: SWCentralDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: SWCentralDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() -> AnyPublisher<[SWCentralNotice], Error> {
        return dataStore.fetch()
    }
}
