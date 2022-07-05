//
//  KWHomeRepositoryTest.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/03.
//

import XCTest
@testable import KWNoticeKit

class KWHomeRepositoryTest_Succeed: XCTestCase {
    
    var repository: KWHomeRepositoryProtocol!
    var titles = [String]()
    var searchTitle = ""
    var searchTargetCount = 0
    
    override func setUp() async throws {
        try await super.setUp()
        
        searchTitle = String.random(3)
        for i in 0..<Int.random(in: 100...1000) {
            titles.append(i % 3 == 0 ? searchTitle + .random(100) : .random(100))
            if i % 3 == 0 { searchTargetCount += 1 }
        }
        
        let dataStore = TestKWHomeDataStore(titles, isSucceedCase: true)
        self.repository = KWHomeRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        self.repository = nil
    }
    
    func test_KWHomeRepository_fetch_shouldReturnNoticesBasedOnGivenTitles() async throws {
        // Given
        
        // When
        let receivedNotices = try await repository.fetch()
        
        // Then
        XCTAssertEqual(receivedNotices.map { $0.title }, titles)
    }
    
    func test_KWHomeRepository_search_shouldReturnNoticesContainSearchTitle_afterFetch() async throws {
        // Given
        let _ = try await repository.fetch()
        
        // When
        let receivedNotices = repository.search(text: searchTitle)
        
        // Then
        XCTAssertGreaterThanOrEqual(receivedNotices.count, searchTargetCount)
    }
}

class KWHomeRepositoryTest_Fail: XCTestCase {
    
    var repository: KWHomeRepositoryProtocol!
    var titles = [String]()
    
    override func setUp() {
        super.setUp()
        
        for _ in 0..<Int.random(in: 100...1000) {
            titles.append(.random(100))
        }
        
        let dataStore = TestKWHomeDataStore(titles, isSucceedCase: false)
        self.repository = KWHomeRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.repository = nil
    }
    
    func test_KWHomeRepository_fetch_shouldThrowError() async {
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
