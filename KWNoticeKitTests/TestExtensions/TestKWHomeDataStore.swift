//
//  TestKWHomeDataStore.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/03.
//

import Combine
@testable import KWNoticeKit

class TestKWHomeDataStore: KWHomeDataStoreProtocol {
    
    // MARK: - Properties
    let notices: [KWHomeNotice]
    let isSucceedCase: Bool
    
    // MARK: - Methods
    init(_ titles: [String], isSucceedCase: Bool) {
        var notices = [KWHomeNotice]()
        
        for title in titles {
            notices.append(KWHomeNotice.stub(title: title))
        }
        
        self.notices = notices
        self.isSucceedCase = isSucceedCase
    }
    
    func fetch() async throws -> [KWHomeNotice] {
        if isSucceedCase {
            return notices
        } else {
            throw APIError.invalidResponse
        }
    }
}

fileprivate extension KWHomeNotice {
    static func stub(
        id: Int = .random(in: 1...100),
        title: String = .random(100),
        tag: String = .random(),
        postedDate: Date = .random(),
        modifiedDate: Date = .random(),
        department: String = .random(),
        url: URL = .random(),
        type: String = .random(),
        crawledTime: Date = .random()
    ) -> KWHomeNotice {
        return .init(
            id: id,
            title: title,
            tag: tag,
//            postedDate: postedDate,
//            modifiedDate: modifiedDate,
            department: department,
            url: url,
            type: type
//            crawledTime: crawledTime
        )
    }
}
