//
//  Notification+CoreDataProperties.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/08.
//
//

import Foundation
import CoreData


extension Notification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notification> {
        return NSFetchRequest<Notification>(entityName: "Notification")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var url: URL?
    @NSManaged public var timestamp: Date

}

extension Notification : Identifiable {

}
