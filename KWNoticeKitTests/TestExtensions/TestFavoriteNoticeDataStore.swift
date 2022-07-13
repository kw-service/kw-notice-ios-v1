//
//  TestFavoriteNoticeDataStore.swift
//  KWNoticeKitTests
//
//  Created by 김세영 on 2022/07/09.
//

import Foundation
import CoreData
@testable import KWNoticeKit

class TestFavoriteNoticeDataStore: FavoriteNoticeDataStoreProtocol {
    
    // MARK: - Properties
    let isSucceedCase: Bool
    
    // MARK: - Methods
    init(isSucceedCase: Bool) {
        self.isSucceedCase = isSucceedCase
    }
    
    func setUp(titles: [String]) {
        for (i, title) in titles.enumerated() {
            guard let entity = NSEntityDescription.entity(
                forEntityName: "Favorite",
                in: persistentContainer.viewContext
            ) else { return }
            entity.setValue(i, forKey: "id")
            entity.setValue(title, forKey: "title")
            entity.setValue((i % 2 == 0) ? "KW_HOME" : "SW_CENTRAL", forKey: "type")
            entity.setValue(Date.now, forKey: "postedDate")
            
            try! persistentContainer.viewContext.save()
        }
    }
    
    func fetch() -> [Favorite]? {
        if isSucceedCase {
            let fetchRequest = Favorite.fetchRequest()
            
            return try? persistentContainer.viewContext.fetch(fetchRequest)
        } else {
            return nil
        }
    }
    
    func save(kwHomeNotice: KWHomeNotice) -> Bool {
        if isSucceedCase {
            return self.save(kwHomeNotice: kwHomeNotice)
        } else {
            return false
        }
    }
    
    func save(swCentralNotice: SWCentralNotice) -> Bool {
        if isSucceedCase {
            return self.save(swCentralNotice: swCentralNotice)
        } else {
            return false
        }
    }
    
    private func save(id: Int, title: String, type: String, postedDate: Date) -> Bool {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Favorite",
            in: persistentContainer.viewContext
        ) else { return false }
        
        do {
            entity.setValue(id, forKey: "id")
            entity.setValue(title, forKey: "title")
            entity.setValue(type, forKey: "type")
            entity.setValue(postedDate, forKey: "postedDate")
            
            try persistentContainer.viewContext.save()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func delete(_ id: Int, type: String) -> Bool {
        if isSucceedCase {
            guard let favorites = self.fetch() else { return false }
            guard let targetFavorite = favorites.first(
                where: { $0.id == id && $0.type == type }
            ) else {
                print("cannot find favorite id - \(id), type - \(type)")
                return false
            }
            persistentContainer.viewContext.delete(targetFavorite)
            do {
                try persistentContainer.viewContext.save()
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteNotice")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                preconditionFailure("error detected: \(error)")
            }
        }
        return container
    }()
}


