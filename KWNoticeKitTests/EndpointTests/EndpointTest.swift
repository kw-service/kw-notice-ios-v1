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
        guard let expectedURL = URL(
            string: "https://n6f11u33jf.execute-api.ap-northeast-2.amazonaws.com/v1/kw-home"
        ) else {
            XCTFail("fail to create URL instance.")
            return
        }
        
        // When
        let url = Endpoint.create(.kwHome)
        
        // Then
        XCTAssertEqual(expectedURL, url)
    }
    
    func test_Endpoint_createAsSWCentral_shouldReturnsExpectedURL() {
        // Given
        guard let expectedURL = URL(
            string: "https://n6f11u33jf.execute-api.ap-northeast-2.amazonaws.com/v1/sw-central"
        ) else {
            XCTFail("fail to create URL instance.")
            return
        }
        
        // When
        let url = Endpoint.create(.swCentral)
        
        // Then
        XCTAssertEqual(expectedURL, url)
    }
}
