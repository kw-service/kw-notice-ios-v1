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

final class TopicSubscriber: ObservableObject {
    
    // MARK: - Properties
    @Published var kwNewNotice: Bool = true
    @Published var kwEditNotice: Bool = true
    
    @available(*, deprecated, message: "SW Notice no longer supported.")
    @Published var swNewNotice: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    init() {
        fetchNoticesState()
        subscribeNoticesState()
    }
    
    // MARK: - Privates
    private func subscribeNoticesState() {
        subscribeKWNewNotice()
        subscribeKWEditNotice()
    }
    
    private func fetchNoticesState() {
        fetchSubscribingState()
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
    
    @available(*, deprecated, message: "SW Notice no longer supported.")
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
        UserDefaults.standard.setSubscribingState(isSubscribing, ofTopic: topic)
    }
    
    private func subscribeTopic(_ topic: Topic) {
        Messaging.messaging().subscribe(toTopic: topic.rawValue) { error in
            if let error = error {
                print("topic subscribe failed with error: \(error.localizedDescription)")
                // publish alert
            } else {
                print("start subscribing \(topic.rawValue)")
            }
        }
    }
    
    private func unsubscribeTopic(_ topic: Topic) {
        Messaging.messaging().unsubscribe(fromTopic: topic.rawValue) { error in
            if let error = error {
                print("topic unsubscribe failed with error: \(error.localizedDescription)")
                // publish alert
            } else {
                print("end subscribing \(topic.rawValue)")
            }
        }
    }
}

// MARK: - Fetch Notices State from UserDefaults
extension TopicSubscriber {
    private func fetchSubscribingState() {
        for topic in Topic.allCases {
            fetchSubscribingState(ofTopic: topic)
        }
    }
    
    private func fetchSubscribingState(ofTopic topic: Topic) {
        guard let state = UserDefaults.standard.isSubscribing(topic: topic) else {
            setNoticeState(true, ofTopic: topic)
            return
        }
        
        setNoticeState(state, ofTopic: topic)
    }
    
    private func setNoticeState(_ state: Bool, ofTopic topic: Topic) {
        switch topic {
        case .kwNewNotice: kwNewNotice = state
        case .kwEditNotice: kwEditNotice = state
        default: return
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
    
    func setSubscribingState(_ state: Bool, ofTopic topic: Topic) {
        self.set(state, forKey: topic.rawValue)
        self.synchronize()
    }
}
