//
//  EndpointTest.swift
//  KWNoticeTests
//
//  Created by 김세영 on 2022/07/03.
//

import XCTest
@testable import KWNoticeKit

class EndpointTest: XCTestCase {
    
    let baseURL = "https://n6f11u33jf.execute-api.ap-northeast-2.amazonaws.com/v1"
    
    func test_Endpoint_createAsKWHome_shouldReturnsExpectedURL() {
        // Given
        let type: Endpoint.Type = .kwHome
        
        // When
        
        // Then
    }
}
