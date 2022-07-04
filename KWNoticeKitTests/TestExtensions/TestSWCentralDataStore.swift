//
//  TestSWCentralDataStore.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/04.
//

import Combine
@testable import KWNoticeKit

class TestSWCentralDataStore: SWCentralDataStoreProtocol {
    
    // MARK: - Properties
    let notices: [SWCentralNotice]
    let isSucceedCase: Bool
    
    // MARK: - Methods
    init(_ titles: [String], isSucceedCase: Bool) {
        var notices = [SWCentralNotice]()
        
        for title in titles {
            notices.append(SWCentralNotice.stub(title: title))
        }
        
        self.notices = notices
        self.isSucceedCase = isSucceedCase
    }
    
    func fetch() -> AnyPublisher<[SWCentralNotice], Error> {
        return Future { [weak self] promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                guard let self = self else {
                    promise(.failure(APIError.invalidResponse))
                    return
                }
                let result: Result<[SWCentralNotice], Error> = (self.isSucceedCase) ?
                    .success(self.notices) : .failure(APIError.invalidCode(code: 500))
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
}

fileprivate extension SWCentralNotice {
    static func stub(
        id: Int = .random(in: 1...100),
        title: String = .random(100),
        postedDate: Date = .random(),
        url: URL = .random(),
        type: String = .random(),
        crawledTime: Date = .random()
    ) -> SWCentralNotice {
        return .init(
            id: id,
            title: title,
            postedDate: postedDate,
            url: url,
            type: type,
            crawledTime: crawledTime
        )
    }
}
