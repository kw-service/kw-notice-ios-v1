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
        return nil
    }
    
    public func save(kwHomeNotice: KWHomeNotice) -> Bool {
        return false
    }
    
    public func save(swCentralNotice: SWCentralNotice) -> Bool {
        return false
    }
    
    public func delete(favorite: Favorite) -> Bool {
        return false
    }
}
