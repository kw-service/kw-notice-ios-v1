//
//  SWCentralNoticeViewModelTest.swift
//  KWNoticeTests
//
//  Created by 김세영 on 2022/07/05.
//

import XCTest
import Combine
import KWNoticeKit
@testable import KWNotice

class SWCentralNoticeViewModelTest_SucceedCase: XCTestCase {

    var viewModel: SWCentralNoticeViewModel!
    var titles = [String]()
    var searchTitle = ""
    var searchTargetCount = 0
    
    override func setUp() async throws {
        try await super.setUp()
        
        searchTitle = .random(10)
        for i in 100...1000 {
            titles.append(i % 3 == 0 ? searchTitle + .random(100) : .random(100))
            if i % 3 == 0 { searchTargetCount += 1 }
        }
        
        DependencyContainer.shared.register(type: SWCentralRepositoryProtocol.self) { _ in
            let dataStore = TestSWCentralDataStore(titles, isSucceedCase: true)
            return SWCentralRepository(dataStore: dataStore)
        }
        viewModel = SWCentralNoticeViewModel()
    }
    
    func test_SWCentralViewModel_fetch_shouldSetNoticesByGivenNotices() async {
        // Given
        
        // When
        await viewModel.fetch()
        let notices = await viewModel.notices
        
        // Then
        XCTAssertEqual(titles, notices.map { $0.title })
    }
    
    func test_SWCentralViewModel_search_shouldSetNoticesByGivenNoticesContainSearchTitle() async {
        // Given
        await viewModel.fetch()
        
        // When
        await viewModel.search(text: searchTitle)
        let notices = await viewModel.notices
        
        // Then
        XCTAssertGreaterThanOrEqual(notices.count, searchTargetCount)
    }
}

class SWCentralNoticeViewModelTest_FailCase: XCTestCase {
    
    var viewModel: SWCentralNoticeViewModel!
    var titles = [String]()
    var searchTitle = ""
    var searchTargetCount = 0
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() async throws {
        searchTitle = .random(3)
        for i in 100...1000 {
            titles.append(i % 3 == 0 ? searchTitle + .random(100) : .random(100))
            if i % 3 == 0 { searchTargetCount += 1 }
        }
        
        DependencyContainer.shared.register(type: SWCentralRepositoryProtocol.self) { _ in
            let dataStore = TestSWCentralDataStore(self.titles, isSucceedCase: false)
            return SWCentralRepository(dataStore: dataStore)
        }
        viewModel = SWCentralNoticeViewModel()
    }
    
    func test_KWHomeNoticeViewModel_fetch_shouldPublishAlert() async {
        // Given
        let expectation = XCTestExpectation(description: #function)
        
        // When
        var alertMessage: String = ""
        viewModel.$alertMessage
            .sink(receiveValue: { receivedAlertMessage in
                alertMessage = receivedAlertMessage
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await viewModel.fetch()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(alertMessage.isEmpty)
    }
}
