//
//  Setting.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import Foundation
import SwiftUI

enum Setting: String {
    case kwNewNotice
    case kwEditNotice
    case swNewNotice
    
    static let githubURL = URL(string: "https://github.com/kw-notice/kw-notice-ios-v1")!
    static let appStoreURL = URL(string: "https://github.com/kw-notice/kw-notice-ios-v1")!
    
    func toTopic() -> String {
        switch self {
            case .kwNewNotice:
                return "kw-home-new"
            case .kwEditNotice:
                return "kw-home-edit"
            case .swNewNotice:
                return "sw-central-new"
        }
    }
}

extension AppStorage {    
    init(_ key: Setting, store: UserDefaults? = nil) where Value == Bool {
        let store = store ?? .standard
        let value = store.bool(forKey: key.rawValue)
        self.init(wrappedValue: value, key.rawValue, store: store)
    }
}
