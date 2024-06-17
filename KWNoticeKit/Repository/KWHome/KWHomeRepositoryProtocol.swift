//
//  KWHomeRepositoryProtocol.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation
import Combine

public protocol KWHomeRepositoryProtocol {
    func fetch() async throws -> [KWHomeNotice]
    func filter(by tag: String) -> [KWHomeNotice]
    func getTag() -> [String]
    func search(text: String) -> [KWHomeNotice]
}
