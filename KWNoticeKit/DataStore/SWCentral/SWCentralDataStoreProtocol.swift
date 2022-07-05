//
//  SWCentralDataStoreProtocol.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation

public protocol SWCentralDataStoreProtocol {
    func fetch() async throws -> [SWCentralNotice]
}
