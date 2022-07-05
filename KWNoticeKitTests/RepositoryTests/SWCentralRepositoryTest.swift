//
//  SWCentralRepositoryTest.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/04.
//

import XCTest
@testable import KWNoticeKit

class SWCentralRepositoryTest_Succeed: XCTestCase {
    
    var repository: SWCentralRepositoryProtocol!
    var titles = [String]()
    var searchTitle = ""
    var searchTargetCount = 0
    
    override func setUp() async throws {
        try await super.setUp()
        
        let baseSearchTitle = String.random(3)
        for i in 0..<Int.random(in: 100...1000) {
            titles.append(i % 3 == 0 ? baseSearchTitle + .random(100) : .random(100))
            if i % 3 == 0 { searchTargetCount += 1 }
        }
        
        let dataStore = TestSWCentralDataStore(titles, isSucceedCase: true)
        self.repository = SWCentralRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.repository = nil
    }
    
    func test_SWCentralRepository_fetch_shouldReturnNoticesBasedOnGivenTitles() async throws {
        // Given
        
        // When
        let receivedNotices = try await repository.fetch()
        
        // Then
        XCTAssertEqual(receivedNotices.map { $0.title }, titles)
    }
    
    func test_SWCentralRepository_search_shouldReturnNoticesContainSearchTitle() {
        // Given
        
        // When
        let receivedNotices = repository.search(text: searchTitle)
        
        // Then
        XCTAssertGreaterThanOrEqual(receivedNotices.count, searchTargetCount)
    }
}

class SWCentralRepositoryTest_Fail: XCTestCase {
    
    var repository: SWCentralRepositoryProtocol!
    var titles = [String]()
    
    override func setUp() {
        super.setUp()
        
        for _ in 0..<Int.random(in: 100...1000) {
            titles.append(.random(100))
        }
        
        let dataStore = TestSWCentralDataStore(titles, isSucceedCase: false)
        self.repository = SWCentralRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.repository = nil
    }
    
    func test_SWCentralRepository_fetch_shouldFinishedWithError() async {
        // Given
        
        // When
        var error: Error?
        do {
            let _ = try await repository.fetch()
        } catch(let receivedError) {
            error = receivedError
        }
        
        // Then
        XCTAssertNotNil(error)
    }
}
