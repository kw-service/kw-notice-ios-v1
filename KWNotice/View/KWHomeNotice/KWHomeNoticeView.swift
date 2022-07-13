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
            switch viewModel.state {
                case .none:
                    noticesList
                case .fetching:
                    ProgressView()
                case .error:
                    PlaceholderView {
                        await viewModel.refresh()
                    }
            }
        }
        .task { await viewModel.fetch() }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isPresented) {
            Button("확인") {}
        }
    }
    
    var noticesList: some View {
        List {
            ForEach(viewModel.notices, id: \.id) { notice in
                NotificationCell(kwHomeNotice: notice)
                    .onTapGesture {
                        UIApplication.shared.open(notice.url)
                    }
                    .swipeActions(edge: .leading) {
                        Button(action: {
                            viewModel.addFavorite(notice)
                        }) {
                            Image(systemName: "star")
                        }
                    }
                    .tint(.yellow)
            }
        }
        .listStyle(.plain)
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

struct KWHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyContainer.shared.register(type: KWHomeRepositoryProtocol.self) { _ in
            let dataStore = KWHomeDataStore()
            return KWHomeRepository(dataStore: dataStore)
        }
        return KWHomeNoticeView()
    }
}
