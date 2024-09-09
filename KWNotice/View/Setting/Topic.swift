//
//  Topic.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/02.
//

import Foundation

enum Topic: String, CaseIterable {
    static var allCases: [Topic] = [.kwNewNotice, .kwEditNotice]
    
    case kwNewNotice = "kw-home-new"
    case kwEditNotice = "kw-home-edit"
    
    @available(*, deprecated, message: "SW Notice no longer supported.")
    case swNewNotice = "sw-central-new"
}
