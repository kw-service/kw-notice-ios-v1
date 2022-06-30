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
}

extension AppStorage {    
    init(_ key: Setting, store: UserDefaults? = nil) where Value == Bool {
        let store = store ?? .standard
        let value = store.bool(forKey: key.rawValue)
        self.init(wrappedValue: value, key.rawValue, store: store)
    }
}
