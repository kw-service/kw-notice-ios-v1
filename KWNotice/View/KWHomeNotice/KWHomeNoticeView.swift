//
//  KWHomeNoticeView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import SwiftUI
import SafariServices
import KWNoticeKit

struct KWHomeNoticeView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = KWHomeNoticeViewModel()
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notices, id: \.id) { notice in
                    contentCell(by: notice)
                        .onTapGesture {
                            openURL(notice.url)
                        }
                }
            }
            .listStyle(.plain)
            .task { await viewModel.fetch() }
            .refreshable {
                if !isSearching {
                    await viewModel.refresh()
                }
            }
            .searchable(text: $searchText, prompt: "공지 검색")
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
                viewModel.search(text: newValue)
            }
            .navigationTitle("광운대학교 공지")
        }
    }
    
    func contentCell(by content: KWHomeNotice) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(content.title)
                    .bold()
                    .lineLimit(1)
                
                Text("작성일 2022-02-12 | 수정일 2022-03-13")
                    .font(.caption)
                    .foregroundColor(.gray)
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
        .padding(.vertical, 8)
    }
}

struct KWHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyContainer.shared.register(type: KWHomeRepositoryProtocol.self) { _ in
            let dataStore = KWHomeDataStore()
            return KWHomeRepository(dataStore: dataStore)
        }
        return KWHomeNoticeView()
    }
}
