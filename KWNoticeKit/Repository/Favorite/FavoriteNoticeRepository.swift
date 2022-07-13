//
//  FavoriteNoticeRepository.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/09.
//

import Foundation

public final class FavoriteNoticeRepository: FavoriteNoticeRepositoryProtocol {
    
    // MARK: - Properties
    private let dataStore: FavoriteNoticeDataStoreProtocol
    
    // MARK: - Methods
    public init(dataStore: FavoriteNoticeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() -> [Favorite]? {
        return dataStore.fetch()
    }
    
    public func save(kwHomeNotice: KWHomeNotice) -> Bool {
        return dataStore.save(kwHomeNotice: kwHomeNotice)
    }
    
    public func save(swCentralNotice: SWCentralNotice) -> Bool {
        return dataStore.save(swCentralNotice: swCentralNotice)
    }
    
    public func delete(favorite: Favorite) -> Bool {
        return dataStore.delete(favorite.id, type: favorite.type)
    }
}
