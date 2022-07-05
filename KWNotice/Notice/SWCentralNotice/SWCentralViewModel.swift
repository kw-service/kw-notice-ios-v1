//
//  SWCentralViewModel.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation
import KWNoticeKit

@MainActor
final class SWCentralViewModel: AlertPublishableObject, ObservableObject {
    
    // MARK: - Properties
    @Resolve private var repository: SWCentralRepositoryProtocol
    @Published var notices = [SWCentralNotice]()
    
    // MARK: - Methods
    @Sendable func fetch() async {
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
