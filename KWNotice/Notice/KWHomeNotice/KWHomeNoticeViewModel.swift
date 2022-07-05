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
    
    enum State {
        case fetching
        case none
    }
    
    // MARK: - Properties
    @Resolve private var repository: KWHomeRepositoryProtocol
    @Published var notices = [KWHomeNotice]()
    @Published private(set) var state = State.none
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    func fetch() async {
        
    }
    
    func search(text: String) {
        
    }
}
