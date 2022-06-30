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
}

extension AppStorage {    
    init(_ key: Setting, store: UserDefaults? = nil) where Value == Bool {
        let store = store ?? .standard
        let value = store.bool(forKey: key.rawValue)
        self.init(wrappedValue: value, key.rawValue, store: store)
    }
}
