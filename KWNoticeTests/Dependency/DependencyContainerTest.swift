//
//  DependencyContainerTest.swift
//  KWNoticeTests
//
//  Created by 김세영 on 2022/07/05.
//

import XCTest
@testable import KWNotice

// MARK: - Use at `test_DependencyContainer_injectTestProtocolType_shouldResolveTestImplementType`
protocol TestProtocol {
    var message: String { get }
}

class TestImplement: TestProtocol {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}

class DependencyContainerTest: XCTestCase {

    func test_DependencyContainer_injectTestProtocolType_shouldResolveTestImplementType() {
        // Given
        let message = #function
        DependencyContainer.shared.register(type: TestProtocol.self) { _ in
            TestImplement(message: message)
        }
        
        // When
        let resolved: TestProtocol = DependencyContainer.shared.resolve()
        
        // Then
        XCTAssertEqual(message, resolved.message)
    }
    
    func test_Resolve_injectTestProtocolType_shouldResolveTestImplementType() {
        // Given
        let message = #function
        DependencyContainer.shared.register(type: TestProtocol.self) { _ in
            TestImplement(message: message)
        }
        
        // When
        @Resolve var resolved: TestProtocol
        
        // Then
        XCTAssertEqual(message, resolved.message)
    }
}
