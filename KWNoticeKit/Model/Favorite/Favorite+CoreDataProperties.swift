//
//  Favorite+CoreDataProperties.swift
//  KWNoticeKit
//
//  Created by 김세영 on 2022/07/09.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var id: Int
    @NSManaged public var postedDate: Date
    @NSManaged public var title: String
    @NSManaged public var type: String
    @NSManaged public var url: URL
}

extension Favorite : Identifiable {

}
