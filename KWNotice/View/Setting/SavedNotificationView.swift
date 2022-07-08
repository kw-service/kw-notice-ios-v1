//
//  SavedNotificationView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/07.
//

import SwiftUI

struct SavedNotificationView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], animation: .linear) var notifications: FetchedResults<Notification>
    @State private var saveErrorDetected: Bool = false
    
    var body: some View {
        VStack {
            if notifications.isEmpty {
                placeholderText
            } else {
                List {
                    ForEach(notifications, id: \.id) { notification in
                        cell(for: notification)
                    }
                    .onDelete(perform: removeNotifications)
                }
                .toolbar {
                    HStack {
                        copyButton
                        EditButton()
                    }
                }
            }
        }
        .navigationTitle("Saved Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .alert("delete data failed.", isPresented: $saveErrorDetected) {
            Text("delete data failed.")
        }
    }
    
    var placeholderText: some View {
        Text("Saved notification not exists.")
            .font(.title)
    }
    
    var copyButton: some View {
        Button("Copy") {
            copyNotificationsAtClipboard()
        }
    }
    
    func cell(for notification: Notification) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(notification.title)
                .bold()
                .lineLimit(1)
            
            Text(notification.body ?? "body is nil.")
                .font(.caption)
            
            Text(notification.url?.path ?? "url is nil.")
                .font(.caption)
            
            Text(notification.timestamp.toString(format: "YYYY-MM-dd HH:mm:ss"))
                .font(.caption)
        }
    }
    
    func removeNotifications(at offsets: IndexSet) {
        for index in offsets {
            let notification = notifications[index]
            moc.delete(notification)
        }
        
        do {
            try moc.save()
        } catch {
            saveErrorDetected = true
        }
    }
    
    func copyNotificationsAtClipboard() {
        var builder = ""
        
        for notification in notifications {
            let notificationString = """
            id: \(notification.id),
            title: \(notification.title),
            body: \(notification.body ?? "body is nil."),
            url: \(notification.url?.absoluteString ?? "url is nil."),
            timestamp: \(notification.timestamp)
            
            """
            builder.append(notificationString)
        }
        
        UIPasteboard.general.string = builder
    }
}

struct SavedNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SavedNotificationView()
    }
}
