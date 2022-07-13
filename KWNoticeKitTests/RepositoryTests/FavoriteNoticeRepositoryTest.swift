//
//  FavoriteNoticeRepositoryTest.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/09.
//

import XCTest
@testable import KWNoticeKit

class FavoriteNoticeRepositoryTest_SucceedCase: XCTestCase {
    
//    var repository: FavoriteNoticeRepositoryProtocol!
//    var titles = [String]()
//
//    override func setUp() {
//        super.setUp()
//
//        for _ in 100...1000 {
//            titles.append(.random())
//        }
//
//        let dataStore = TestFavoriteNoticeDataStore(isSucceedCase: true)
//        dataStore.setUp(titles: titles)
//        repository = FavoriteNoticeRepository(dataStore: dataStore)
//    }
//
//    func test_FavoriteNoticeRepository_fetch_shouldReturnFavoritesContainGivenTitles() {
//        // Given
//
//        // When
//        guard let favorites = repository.fetch() else {
//            XCTFail("favorite must not nil.")
//            return
//        }
//
//        // Then
//        XCTAssertFalse(favorites.isEmpty)
//        for i in 0..<favorites.count {
//            XCTAssertEqual(favorites[i].title, titles[i])
//        }
//    }
//
//    func test_FavoriteNoticeRepository_saveKWHomeNotice_shouldReturnTrue_andSetTypeAsKWHome() {
//        // Given
//        let kwHomeNotice = KWHomeNotice(
//            id: .random(in: (titles.count + 1)...(titles.count + 100)),
//            title: .random(),
//            tag: .random(),
//            department: .random(),
//            url: .random(),
//            type: "KW_HOME"
//        )
//
//        // When
//        let result = repository.save(kwHomeNotice: kwHomeNotice)
//
//        // Then
//        XCTAssertTrue(result)
//
//        guard let appendedFavorite = repository.fetch()?.last else {
//            XCTFail("invalid test.")
//            return
//        }
//        XCTAssertEqual(appendedFavorite.type, "KW_HOME")
//    }
//
//    func test_FavoriteNoticeRepository_saveSWCentralNotice_shouldReturnTrue_andSetTypeAsSWCentral() {
//        // Given
//        let swCentralNotice = SWCentralNotice(
//            id: .random(in: (titles.count + 1)...(titles.count + 100)),
//            title: .random(),
//            url: .random(),
//            type: "SW_CENTRAL"
//        )
//
//        // When
//        let result = repository.save(swCentralNotice: swCentralNotice)
//
//        // Then
//        XCTAssertTrue(result)
//
//        guard let appendedFavorite = repository.fetch()?.last else {
//            XCTFail("invalid test.")
//            return
//        }
//        XCTAssertEqual(appendedFavorite.type, "SW_CENTRAL")
//    }
//
//    func test_FavoriteNoticeRepository_deleteKWHomeNotice_shouldDeleteFavoriteAndReturnTrue() {
//        // Given
//        guard let targetFavorite = repository.fetch()?.randomElement() else {
//            XCTFail("invalid target notice.")
//            return
//        }
//
//        // When
//        let result = repository.delete(favorite: targetFavorite)
//
//        // Then
//        guard let fetchedFavorite = repository.fetch() else {
//            XCTFail("invalid test.")
//            return
//        }
//        XCTAssertFalse(fetchedFavorite.contains(targetFavorite))
//        XCTAssertTrue(result)
//    }
}

class FavoriteNoticeRepositoryTest_FailCase: XCTestCase {
    
//    var repository: FavoriteNoticeRepositoryProtocol!
//    var titles = [String]()
//
//    override func setUp() {
//        super.setUp()
//
//        for _ in 100...1000 {
//            titles.append(.random())
//        }
//
//        let dataStore = TestFavoriteNoticeDataStore(isSucceedCase: true)
//        dataStore.setUp(titles: titles)
//        repository = FavoriteNoticeRepository(dataStore: dataStore)
//    }
//
//    func test_FavoriteNoticeRepository_fetch_shouldReturnNil() {
//        // Given
//
//        // When
//        let favorites = repository.fetch()
//
//        // Then
//        XCTAssertNil(favorites)
//    }
//
//    func test_FavoriteNoticeRepository_saveKWHomeNotice_shouldReturnFalse() {
//        // Given
//        let kwHomeNotice = KWHomeNotice(
//            id: .random(in: (titles.count + 1)...(titles.count + 100)),
//            title: .random(),
//            tag: .random(),
//            department: .random(),
//            url: .random(),
//            type: "KW_HOME"
//        )
//
//        // When
//        let result = repository.save(kwHomeNotice: kwHomeNotice)
//
//        // Then
//        XCTAssertFalse(result)
//    }
//
//    func test_FavoriteNoticeRepository_saveSWCentralNotice_shouldReturnFalse() {
//        // Given
//        let swCentralNotice = SWCentralNotice(
//            id: .random(in: (titles.count + 1)...(titles.count + 100)),
//            title: .random(),
//            url: .random(),
//            type: "SW_CENTRAL"
//        )
//
//        // When
//        let result = repository.save(swCentralNotice: swCentralNotice)
//
//        // Then
//        XCTAssertFalse(result)
//    }
//
//    func test_FavoriteNoticeRepository_deleteKWHomeNotice_shouldReturnFalse() {
//        // Given
//        guard let targetFavorite = repository.fetch()?.randomElement() else {
//            XCTFail("invalid target favorite.")
//            return
//        }
//
//        // When
//        let result = repository.delete(favorite: targetFavorite)
//
//        // Then
//        XCTAssertFalse(result)
//    }
}
