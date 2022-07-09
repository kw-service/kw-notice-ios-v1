//
//  FavoriteNoticeDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/09.
//

import Foundation

public protocol FavoriteNoticeDataStoreProtocol {
    func fetch() -> Result<[Favorite], Error>
    func save(_ favorite: Favorite) -> Bool
    func delete(_ id: Int) -> Bool
}
