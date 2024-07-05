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
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var presentingSelectTagView = false
    
    @State var selectedNoticeTag = "전체"
        
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
                case .none:
                    noticesList
                case .fetching:
                    ProgressView()
                case .error:
                    PlaceholderView(navigationTitle: "광운대학교 공지") {
                        await viewModel.refresh()
                    }
            }
        }
        .task { await viewModel.fetch() }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isPresented) {
            Button("확인") {}
        }
        .navigationViewStyle(.stack)
    }
    
    var noticesList: some View {
        searchResult
            .listStyle(.plain)
            .refreshable {
                if !isSearching {
                    await viewModel.refresh()
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "공지 검색"
            )
            .toolbar {
                Button(selectedNoticeTag) { self.presentingSelectTagView = true }
                    .sheet(isPresented: $presentingSelectTagView, content: {
                        SelectNoticeTagView(selectedNoticeTag: $selectedNoticeTag)
                    })
            }
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
                viewModel.search(text: newValue)
            }
            .onChange(of: selectedNoticeTag) { selectedTag in
                self.presentingSelectTagView = false
                viewModel.filter(by: selectedTag)
            }
            .navigationTitle("광운대학교 공지")
    }
    
    @ViewBuilder var searchResult: some View {
        if isSearching && viewModel.notices.isEmpty {
            NoSearchResultView()
        } else {
            searchList
        }
    }
    
    var searchList: some View {
        List {
            ForEach(viewModel.notices, id: \.id) { notice in
                NotificationCell(kwHomeNotice: notice)
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
