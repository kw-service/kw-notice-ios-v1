//
//  FavoriteViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/13.
//

import Foundation
import KWNoticeKit

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
        favorites = fetchedFavorites
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
}
