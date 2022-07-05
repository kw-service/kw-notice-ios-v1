//
//  KWHomeDataStoreProtocol.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation

public protocol KWHomeDataStoreProtocol {
    func fetch() async throws -> [KWHomeNotice]
}
