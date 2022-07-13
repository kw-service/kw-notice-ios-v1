//
//  FavoriteNoticeRepositoryProtocol.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/09.
//

import Foundation

public protocol FavoriteNoticeRepositoryProtocol {
    func fetch() -> [Favorite]?
    func save(kwHomeNotice: KWHomeNotice) -> Bool
    func save(swCentralNotice: SWCentralNotice) -> Bool
    func delete(favorite: Favorite) -> Bool
    func isFavorite(kwHomeNotice: KWHomeNotice) -> Bool
    func isFavorite(swCentralNotice: SWCentralNotice) -> Bool
}
