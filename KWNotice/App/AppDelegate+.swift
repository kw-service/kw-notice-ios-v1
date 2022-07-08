//
//  AppDelegate+.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/07.
//

import Foundation
import CoreData

// Extension for save notification
extension AppDelegate {
    
    func saveNotification(parseFrom userInfo: [AnyHashable: Any]) {
        var notification: (title: String, body: String?, url: URL?) = ("", nil, nil)
        defer {
            let notificationEntity = NSEntityDescription.entity(
                forEntityName: "Notification",
                in: self.persistentContainer.viewContext
            )
            if let notificationEntity = notificationEntity {
                let notificationObject = NSManagedObject(
                    entity: notificationEntity,
                    insertInto: self.persistentContainer.viewContext
                )
                notificationObject.setValue(UUID(), forKey: "id")
                notificationObject.setValue(notification.title, forKey: "title")
                notificationObject.setValue(notification.body, forKey: "body")
                notificationObject.setValue(notification.url, forKey: "url")
                notificationObject.setValue(Date.now, forKey: "timestamp")
                
                do {
                    try self.persistentContainer.viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        guard let aps = userInfo["aps"] as? NSDictionary else {
            notification.title = "aps not exists."
            return
        }
        guard let alert = aps["alert"] as? NSDictionary else {
            notification.title = "cannot parse alert from aps."
            return
        }
        guard let title = (alert["title"] as? NSString) as? String,
              let body = (alert["body"] as? NSString) as? String else {
            notification.title = "cannot parse title or body from alert."
            return
        }
        guard let urlString = userInfo["url"] as? NSString,
              let url = URL(string: urlString as String) else {
            notification.title = "cannot parse url from received notification."
            return
        }
        notification.title = title
        notification.body = body
        notification.url = url
    }
}
