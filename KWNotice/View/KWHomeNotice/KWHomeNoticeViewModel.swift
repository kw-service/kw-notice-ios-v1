//
//  KWHomeNoticeViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation
import Combine
import KWNoticeKit

@MainActor
final class KWHomeNoticeViewModel: AlertPublishableObject, ObservableObject {
    
    // MARK: - Properties
    @Resolve private var repository: KWHomeRepositoryProtocol
    @Published var notices = [KWHomeNotice]()
    
    private var cancellable: AnyCancellable?
    private var isAlreadyFetched = false
    
    // MARK: - Methods
    func fetch() async {
        guard !isAlreadyFetched else { return }
        
        do {
            notices = try await repository.fetch()
            isAlreadyFetched = true
        } catch {
            sendAlert()
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
