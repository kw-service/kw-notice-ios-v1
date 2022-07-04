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
    
    public func fetch() -> AnyPublisher<[KWHomeNotice], Error> {
        return dataStore.fetch()
            .map { [weak self] notices -> [KWHomeNotice] in
                self?.notices = notices
                return notices
            }
            .eraseToAnyPublisher()
    }
    
    public func search(text: String) -> AnyPublisher<[KWHomeNotice], Never> {
        let resultNotices = notices.filter { $0.title.contains(text) }
        
        return Just(resultNotices)
            .eraseToAnyPublisher()
    }
}
