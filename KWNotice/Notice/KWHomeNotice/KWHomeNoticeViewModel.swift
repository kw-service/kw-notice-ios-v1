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
        
    }
    
    func search(text: String) {
        
    }
}
