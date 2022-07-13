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
    var addFavoriteAction: () -> Void
    
    init(kwHomeNotice: KWHomeNotice, addFavorite action: @escaping () -> Void) {
        self.title = kwHomeNotice.title
        self.dateInfo = "작성일 \(Date.now) | 수정일 \(Date.now)"
        self.department = kwHomeNotice.department
        self.addFavoriteAction = action
    }
    
    init(swCentralNotice: SWCentralNotice, addFavorite action: @escaping () -> Void) {
        self.title = swCentralNotice.title
        self.dateInfo = "작성일 \(Date.now)"
        self.department = nil
        self.addFavoriteAction = action
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .bold()
                    .lineLimit(1)
                
                Text(dateInfo)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let department = department {
                    Text(department)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: addFavoriteAction) {
                Image(systemName: "star")
            }
        }
        .padding(.vertical, 8)
    }
}

fileprivate extension NotificationCell {
    init(title: String, dateInfo: String, department: String?) {
        self.title = title
        self.dateInfo = dateInfo
        self.department = department
        self.addFavoriteAction = {}
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(title: "title", dateInfo: "date info", department: "department")
    }
}
