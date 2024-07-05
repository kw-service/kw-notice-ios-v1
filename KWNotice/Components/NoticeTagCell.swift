//
//  NoticeTagCell.swift
//  KWNotice
//
//  Created by 장석우 on 6/14/24.
//

import SwiftUI
import KWNoticeKit

struct NoticeTagCell: View {
    
    let title: String
    @Binding var selectedNoticeTag: String
    
    var body: some View {
        HStack() {
            Text(title)
                .fontWeight(.medium)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 16)
                .foregroundColor(.accentColor)
                .opacity(title == selectedNoticeTag ? 1 : 0)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedNoticeTag = title
        }
    }
}

fileprivate extension NoticeTagCell {
    init(mockTitle: String) {
        self.title = mockTitle
        self._selectedNoticeTag = .constant("Mock")
    }
}

struct NoticeTypeCell_Previews: PreviewProvider {
    static var previews: some View {
        NoticeTagCell(mockTitle: "전체")
    }
}

