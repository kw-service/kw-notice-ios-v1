//
//  NotificationCell.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/08.
//

import SwiftUI
import KWNoticeKit

struct NotificationCell: View {
    
    let title: String
    let dateInfo: String
    let department: String?
    let url: URL
    
    @State private var isNotificationTapped = false
    @State private var isPresentedSafari = false
    @AppStorage(Setting.useExternalBrowser) private var useExternalBrowser = false
    
    init(kwHomeNotice: KWHomeNotice) {
        self.title = kwHomeNotice.title
        self.dateInfo = "작성일 \(kwHomeNotice.postedDate.toString()) | 수정일 \(kwHomeNotice.modifiedDate.toString())"
        self.department = kwHomeNotice.department
        self.url = kwHomeNotice.url
    }
    
    init(swCentralNotice: SWCentralNotice) {
        self.title = swCentralNotice.title
        self.dateInfo = "작성일 \(swCentralNotice.postedDate.toString())"
        self.department = nil
        self.url = swCentralNotice.url
    }
    
    init(favorite: Favorite) {
        self.title = favorite.title
        self.dateInfo = "작성일 \(favorite.postedDate.toString())"
        self.department = nil
        self.url = favorite.url
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .bold()
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Text(dateInfo)
                .font(.caption)
                .foregroundColor(.gray)
            
            if let department = department {
                Text(department)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            isNotificationTapped = true
        }
        .onChange(of: isNotificationTapped) { _ in
            isNotificationTapped = false
            if useExternalBrowser {
                print(url)
                UIApplication.shared.open(url)
            } else {
                isPresentedSafari = true
            }
        }
        .fullScreenCover(isPresented: $isPresentedSafari) {
            SafariView(url: url)
                .ignoresSafeArea()
        }
    }
}

fileprivate extension NotificationCell {
    init(title: String, dateInfo: String, department: String?) {
        self.title = title
        self.dateInfo = dateInfo
        self.department = department
        self.url = URL(string: "https://www.google.com")!
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(title: "title", dateInfo: "date info", department: "department")
    }
}
