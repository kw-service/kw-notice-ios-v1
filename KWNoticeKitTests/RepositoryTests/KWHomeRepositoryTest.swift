//
//  KWHomeRepositoryTest.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/03.
//

import XCTest
import Combine
@testable import KWNoticeKit

class KWHomeRepositoryTest_Succeed: XCTestCase {
    
    var repository: KWHomeRepositoryProtocol!
    var titles = [String]()
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        
        for _ in 0..<Int.random(in: 100...1000) {
            titles.append(.random(100))
        }
        
        let dataStore = TestKWHomeDataStore(titles, isSucceedCase: true)
        self.repository = KWHomeRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.cancellable?.cancel()
        
        self.repository = nil
        self.cancellable = nil
    }
    
    func test_KWHomeRepository_fetch_shouldReturnNoticesBasedOnGivenTitles() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        
        // When
        var notices = [KWHomeNotice]()
        cancellable = repository.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        XCTFail("failed with error - \(error)")
                    case .finished:
                        break
                }
            }, receiveValue: { receivedNotices in
                notices = receivedNotices
                expectation.fulfill()
            })
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(titles.count, notices.count)
        for (i, notice) in notices.enumerated() {
            XCTAssertEqual(titles[i], notice.title)
        }
    }
    
    func test_KWHomeRepository_search_shouldReturnEmpty_beforeFetch() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        
        // When
        var notices = [KWHomeNotice]()
        cancellable = repository.search(text: .random())
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        XCTFail("failed with error - \(error)")
                    case .finished:
                        break
                }
            }, receiveValue: { receivedNotices in
                notices = receivedNotices
                expectation.fulfill()
            })
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(notices.isEmpty)
    }
    
    func test_KWHomeRepository_search_shouldReturnNoticesContainsGivenText_afterFetch() {
        // Given
        var titles = [String]()
        var targetCount = 0
        let searchText = String.random(.random(in: 3...10))
        for i in 10..<Int.random(in: 100...1000) {
            let title = (i % 3 == 0) ? ("\(searchText)" + .random(100)) : .random(100)
            if i % 3 == 0 { targetCount += 1 }
            titles.append(title)
        }
        
        let fetchExpectation = XCTestExpectation(description: "\(#function)_fetching")
        let dataStore = TestKWHomeDataStore(titles, isSucceedCase: true)
        self.repository = KWHomeRepository(dataStore: dataStore)
        cancellable = repository.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        XCTFail("failed with error - \(error.localizedDescription)")
                    case .finished:
                        break
                }
            }, receiveValue: { _ in fetchExpectation.fulfill() })
        
        wait(for: [fetchExpectation], timeout: 1)
        let searchExpectation = XCTestExpectation(description: #function)
        
        // When
        var notices = [KWHomeNotice]()
        cancellable = repository.search(text: searchText)
            .sink(receiveValue: { receivedNotices in
                notices = receivedNotices
                searchExpectation.fulfill()
            })
        
        // Then
        wait(for: [searchExpectation], timeout: 1)
        XCTAssertGreaterThanOrEqual(notices.count, targetCount)
    }
}

class KWHomeRepositoryTest_Fail: XCTestCase {
    
    var repository: KWHomeRepositoryProtocol!
    var titles = [String]()
    private var cancellable: AnyCancellable?
    
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
        
        self.cancellable?.cancel()
        
        self.repository = nil
        self.cancellable = nil
    }
    
    func test_KWHomeRepository_fetch_shouldFinishedWithError() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        
        // When
        cancellable = repository.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure:
                        expectation.fulfill()
                    case .finished:
                        XCTFail("test must failed with error.")
                }
            }, receiveValue: { receivedNotificaion in
                XCTFail("failed with receive value - \(receivedNotificaion)")
            })
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
