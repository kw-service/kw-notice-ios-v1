//
//  KWHomeDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/03.
//

import Foundation
import Combine

public final class KWHomeDataStore: KWHomeDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public func fetch() -> AnyPublisher<[KWHomeNotice], Error> {
        let url = Endpoint.create(.kwHome)
        
        return APIRequest.shared.get(url)
            .decode(type: [KWHomeNotice].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
