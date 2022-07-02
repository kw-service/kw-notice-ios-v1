//
//  TopicSubscriber.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/02.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseMessaging

final class TopicSubscriber {
    
    // MARK: - Properties
    @Published private(set) var kwNewNotice: Bool = true
    @Published private(set) var kwEditNotice: Bool = true
    @Published private(set) var swNewNotice: Bool = true
    
    // MARK: - Methods
    init() {
        fetchSubcribeState()
    }
    
    private func fetchSubcribeState() {
        
    }
}
