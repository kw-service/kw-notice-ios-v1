//
//  SWCentralNoticeViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation
import KWNoticeKit

@available(*, deprecated, message: "SW Notice no longer supported.")
@MainActor
final class SWCentralNoticeViewModel: AlertPublishableObject, ObservableObject {
    
    enum State {
        case none
        case fetching
        case error
    }
    
    // MARK: - Properties
    @Resolve private var repository: SWCentralRepositoryProtocol
    @Resolve private var favoriteRepository: FavoriteNoticeRepositoryProtocol
    @Published var notices = [SWCentralNotice]()
    
    private(set) var state = State.none
    private var isAlreadyFetched = false
    
    // MARK: - Methods
    func fetch() async {
        guard !isAlreadyFetched else { return }
        
        state = .fetching
        do {
            notices = try await repository
                .fetch()
                .sorted(by: >)
            isAlreadyFetched = true
            state = .none
        } catch {
            sendAlert()
            state = .error
        }
    }
    
    func refresh() async {
        isAlreadyFetched = false
        await fetch()
    }
    
    func search(text: String) {
        notices = repository.search(text: text)
            .sorted(by: >)
    }
    
    func addFavorite(_ notice: SWCentralNotice) {
        if !favoriteRepository.save(swCentralNotice: notice) {
            sendAlert(with: "즐겨찾기 추가 중 오류가 발생했습니다.")
            return
        }
        sendAlert(with: "즐겨찾기에 추가되었습니다.")
    }
}
