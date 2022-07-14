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
    
    public func save(kwHomeNotice: KWHomeNotice) -> Bool {
        return self.save(
            id: kwHomeNotice.id,
            title: kwHomeNotice.title,
            type: kwHomeNotice.type,
            postedDate: kwHomeNotice.postedDate,
            url: kwHomeNotice.url
        )
    }
    
    public func save(swCentralNotice: SWCentralNotice) -> Bool {
        return self.save(
            id: swCentralNotice.id,
            title: swCentralNotice.title,
            type: swCentralNotice.type,
            postedDate: swCentralNotice.postedDate,
            url: swCentralNotice.url
        )
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
    
    // MARK: - Privates
    private func save(id: Int, title: String, type: String, postedDate: Date, url: URL) -> Bool {
        if isAlreadyExist(id: id, type: type) { return true }
        
        guard let entity = NSEntityDescription.entity(
            forEntityName: "Favorite",
            in: persistentContainer.viewContext
        ) else { return false }
    
        let favoriteObject = NSManagedObject(
            entity: entity,
            insertInto: persistentContainer.viewContext
        )
        favoriteObject.setValue(id, forKey: "id")
        favoriteObject.setValue(title, forKey: "title")
        favoriteObject.setValue(type, forKey: "type")
        favoriteObject.setValue(postedDate, forKey: "postedDate")
        favoriteObject.setValue(url, forKey: "url")
        
        do {
            try persistentContainer.viewContext.save()
            
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func isAlreadyExist(id: Int, type: String) -> Bool {
        guard let notices = fetch() else { return false }
        
        return notices.contains(where: { $0.id == id && $0.type == type })
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
