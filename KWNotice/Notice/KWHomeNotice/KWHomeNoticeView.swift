//
//  KWHomeNoticeView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import SwiftUI
import KWNoticeKit

struct KWHomeNoticeView: View {
    
    @StateObject var viewModel = KWHomeNoticeViewModel()
    
    var body: some View {
        List {
            ForEach($viewModel.notices) { notice in
                contentCell(by: notice.wrappedValue)
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
    
    func contentCell(by content: KWHomeNotice) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(content.title)
                    .bold()
                    .lineLimit(1)
                
//                Text("작성일 \(content.postedDate) | 수정일 \(content.modifiedDate)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
                
                Text(content.department)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "star")
            }
        }
        .padding(.vertical, 5)
    }
}

struct KWHomeView_Previews: PreviewProvider {
    static var previews: some View {
        KWHomeNoticeView()
    }
}
