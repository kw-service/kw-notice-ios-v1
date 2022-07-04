//
//  SWCentralRepositoryTest.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/04.
//

import XCTest
import Combine
@testable import KWNoticeKit

class SWCentralRepositoryTest_Succeed: XCTestCase {
    
    var repository: SWCentralRepositoryProtocol!
    var titles = [String]()
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        
        for _ in 0..<Int.random(in: 100...1000) {
            titles.append(.random(100))
        }
        
        let dataStore = TestSWCentralDataStore(titles, isSucceedCase: true)
        self.repository = SWCentralRepository(dataStore: dataStore)
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.cancellable?.cancel()
        
        self.repository = nil
        self.cancellable = nil
    }
    
    func test_SWCentralRepository_fetch_shouldReturnNoticesBasedOnGivenTitles() {
        // Given
        let expectation = XCTestExpectation(description: #function)
        
        // When
        var notices = [SWCentralNotice]()
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
}

class SWCentralRepositoryTest_Fail: XCTestCase {
    
    var repository: SWCentralRepositoryProtocol!
    var titles = [String]()
    private var cancellable: AnyCancellable?
    
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
        
        self.cancellable?.cancel()
        
        self.repository = nil
        self.cancellable = nil
    }
    
    func test_SWCentralRepository_fetch_shouldFinishedWithError() {
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
