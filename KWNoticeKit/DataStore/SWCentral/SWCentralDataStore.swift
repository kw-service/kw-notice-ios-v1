//
//  SWCentralDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation
import Combine

public final class SWCentralDataStore: SWCentralDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func fetch() -> AnyPublisher<[SWCentralNotice], Error> {
        let url = Endpoint.create(.swCentral)
        
        return APIRequest.shared.get(url)
            .decode(type: [SWCentralNotice].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
