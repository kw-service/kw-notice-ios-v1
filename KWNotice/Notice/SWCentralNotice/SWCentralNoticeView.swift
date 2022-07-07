//
//  SWCentralNoticeView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import SwiftUI
import KWNoticeKit

struct SWCentralNoticeView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = SWCentralNoticeViewModel()
    
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notices, id: \.id) { notice in
                    contentCell(by: notice)
                        .onTapGesture {
                            UIApplication.shared.open(notice.url)
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("SW사업단 공지사항")
            .task(viewModel.fetch)
            .refreshable(action: viewModel.fetch)
            .searchable(text: $searchText, prompt: "공지 검색")
            .onChange(of: searchText) { newValue in
                viewModel.search(text: newValue)
            }
        }
    }
    
    func contentCell(by content: SWCentralNotice) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(content.title)
                    .bold()
                    .lineLimit(1)
                
                Text("작성일 2022-02-12")
                    .font(.caption)
                    .foregroundColor(.gray)
                //                Text("작성일 \(content.postedDate) | 수정일 \(content.modifiedDate)")
                //                    .font(.caption)
                //                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "star")
            }
        }
        .padding(.vertical, 8)
    }
}

struct SWCentralNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        SWCentralNoticeView()
    }
}
