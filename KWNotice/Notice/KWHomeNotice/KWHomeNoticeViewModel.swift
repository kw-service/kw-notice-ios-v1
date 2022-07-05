//
//  KWHomeNoticeViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation
import Combine
import KWNoticeKit

final class KWHomeNoticeViewModel: AlertPublishableObject, ObservableObject {
    
    // MARK: - Properties
    @Resolve private var repository: KWHomeRepositoryProtocol
    @Published var notices = [KWHomeNotice]()
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    func fetch() async {
        do {
            notices = try await repository.fetch()
        } catch {
            sendAlert()
        }
    }
    
    func search(text: String) {
        notices = repository.search(text: text)
    }
}
