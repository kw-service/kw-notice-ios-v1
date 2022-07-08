//
//  SWCentralNoticeViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation
import KWNoticeKit

@MainActor
final class SWCentralNoticeViewModel: AlertPublishableObject, ObservableObject {
    
    enum State {
        case none
        case fetching
        case error
    }
    
    // MARK: - Properties
    @Resolve private var repository: SWCentralRepositoryProtocol
    @Published var notices = [SWCentralNotice]()
    
    private(set) var state = State.none
    private var isAlreadyFetched = false
    
    // MARK: - Methods
    func fetch() async {
        guard !isAlreadyFetched else { return }
        
        state = .fetching
        do {
            notices = try await repository.fetch()
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
    }
}
