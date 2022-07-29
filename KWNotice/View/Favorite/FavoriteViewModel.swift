//
//  FavoriteViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/13.
//

import Foundation
import KWNoticeKit
import Fuse

final class FavoriteViewModel: AlertPublishableObject, ObservableObject {
    
    enum State {
        case noContent
        case fetched
        case error
    }
    
    // MARK: - Properties
    @Resolve var repository: FavoriteNoticeRepositoryProtocol
    @Published var favorites = [Favorite]()
    @Published private(set) var state = State.noContent
    
    private var originFavorites = [Favorite]()
    
    // MARK: - Methods
    func fetch() {
        guard let fetchedFavorites = repository.fetch() else {
            sendAlert()
            state = .error
            return
        }
        if fetchedFavorites.isEmpty {
            state = .noContent
            return
        }
        state = .fetched
        favorites = fetchedFavorites.sorted(by: >)
        originFavorites = favorites
    }
    
    func search(_ text: String) {
        if text.isEmpty {
            favorites = originFavorites.sorted(by: >)
        } else {
            favorites = fuseSearch(text).sorted(by: >)
        }
    }
    
    func delete(at indices: IndexSet) {
        for i in indices {
            let favorite = favorites[i]
            let isDeleted = repository.delete(favorite: favorite)
            if !isDeleted {
                sendAlert()
                return
            }
        }
        fetch()
    }
    
    private func fuseSearch(_ text: String) -> [Favorite] {
        let fuse = Fuse()
        return fuse.search(text, in: favorites.map { $0.title })
            .map { favorites[$0.index] }
    }
}

