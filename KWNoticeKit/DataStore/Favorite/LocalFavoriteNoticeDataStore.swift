//
//  LocalFavoriteNoticeDataStore.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/09.
//

import Foundation
import CoreData

public final class LocalFavoriteNoticeDataStore: FavoriteNoticeDataStoreProtocol {
    
    // MARK: - Properties
    
    // MARK: - Methods
    public init() {}
    
    public func fetch() -> [Favorite]? {
        let request = Favorite.fetchRequest()
        
        do {
            let fetchedFavorites = try persistentContainer.viewContext.fetch(request)
            return fetchedFavorites
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func save(_ favorite: Favorite) -> Bool {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Favorite",
            in: persistentContainer.viewContext
        ) else { return false }
        
        do {
            entity.setValue(favorite.id, forKey: "id")
            entity.setValue(favorite.title, forKey: "title")
            entity.setValue(favorite.type, forKey: "type")
            entity.setValue(favorite.postedDate, forKey: "postedDate")
            
            try persistentContainer.viewContext.save()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public func delete(_ id: Int, type: String) -> Bool {
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
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteNotice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                preconditionFailure("error detected: \(error)")
            }
        })
        return container
    }()
}
