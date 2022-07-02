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
    @Published var kwNewNotice: Bool = true
    @Published var kwEditNotice: Bool = true
    @Published var swNewNotice: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    init() {
        subscribeNoticesState()
    }
    
    // MARK: - Privates
    private func subscribeNoticesState() {
        subscribeKWNewNotice()
        subscribeKWEditNotice()
        subscribeSWNewNotice()
    }
}

// MARK: - Subscribe Publisher of TopicSubscriber
extension TopicSubscriber {
    private func subscribeKWNewNotice() {
        $kwNewNotice
            .sink(receiveValue: { [weak self] subscribeState in
                self?.setSubscribeState(subscribeState, ofTopic: .kwNewNotice)
            })
            .store(in: &cancellables)
    }
    
    private func subscribeKWEditNotice() {
        $kwEditNotice
            .sink(receiveValue: { [weak self] subscribeState in
                self?.setSubscribeState(subscribeState, ofTopic: .kwEditNotice)
            })
            .store(in: &cancellables)
    }
    
    private func subscribeSWNewNotice() {
        $swNewNotice
            .sink(receiveValue: { [weak self] subscribeState in
                self?.setSubscribeState(subscribeState, ofTopic: .swNewNotice)
            })
            .store(in: &cancellables)
    }
    
    private func setSubscribeState(_ isSubscribing: Bool, ofTopic topic: Topic) {
        if isSubscribing {
            subscribeTopic(topic)
        } else {
            unsubscribeTopic(topic)
        }
    }
    
    private func subscribeTopic(_ topic: Topic) {
        Messaging.messaging().subscribe(toTopic: topic.rawValue) { error in
            if let error = error {
                print("topic subscribe failed with error: \(error.localizedDescription)")
                // publish alert
            }
        }
    }
    
    private func unsubscribeTopic(_ topic: Topic) {
        Messaging.messaging().subscribe(toTopic: topic.rawValue) { error in
            if let error = error {
                print("topic unsubscribe failed with error: \(error.localizedDescription)")
                // publish alert
            }
        }
    }
}

// MARK: - UserDefault extension method
fileprivate extension UserDefaults {
    
    /// Fetch subscribe state of given topic.
    /// - Parameter topic: fetch state of given `topic`.
    /// - Returns: returns `Bool` if state exists(saved). returns `nil` when value is not exists.
    func isSubscribing(topic: Topic) -> Bool? {
        return self.object(forKey: topic.rawValue) as? Bool
    }
}
