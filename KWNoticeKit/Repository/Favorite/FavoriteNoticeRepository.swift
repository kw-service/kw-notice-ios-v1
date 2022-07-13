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
    private let favoritesCache = NSCache<NSString, Favorite>()
    
    // MARK: - Methods
    public init(dataStore: FavoriteNoticeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    public func fetch() -> [Favorite]? {
        guard let favorites = dataStore.fetch() else { return nil }
        for favorite in favorites {
            let key = makeKey(byId: favorite.id, type: favorite.type)
            favoritesCache.setObject(favorite, forKey: key)
        }
        return favorites
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
    
    public func isFavorite(kwHomeNotice: KWHomeNotice) -> Bool {
        let key = makeKey(byId: kwHomeNotice.id, type: kwHomeNotice.type)
        guard let _ = favoritesCache.object(forKey: key) else { return false }
        return true
    }
    
    public func isFavorite(swCentralNotice: SWCentralNotice) -> Bool {
        let key = makeKey(byId: swCentralNotice.id, type: swCentralNotice.type)
        guard let _ = favoritesCache.object(forKey: key) else { return false }
        return true
    }
    
    // MARK: - Privates
    private func makeKey(byId id: Int, type: String) -> NSString {
        return "\(type)_\(id)" as NSString
    }
}
