//
//  FavoriteView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI
import KWNoticeKit

struct FavoriteView: View {
    
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = FavoriteViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("즐겨찾기")
        }
        .onAppear {
            viewModel.fetch()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isPresented) {
            Button("확인") {}
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder var contentView: some View {
        switch viewModel.state {
            case .noContent:
                fetchFailed
            case .fetched:
                favoritesList
            case .error:
                PlaceholderView(navigationTitle: "즐겨찾기") {
                    viewModel.fetch()
                }
        }
    }
    
    var favoritesList: some View {
        searchResult
            .listStyle(.plain)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "즐겨찾기 검색"
            )
            .toolbar {
                EditButton()
            }
            .onChange(of: searchText) { newValue in
                isSearching = !newValue.isEmpty
                viewModel.search(newValue)
            }
    }
    
    @ViewBuilder var searchResult: some View {
        if isSearching && viewModel.favorites.isEmpty {
            NoSearchResultView()
        } else {
            searchList
        }
    }
    
    var searchList: some View {
        List {
            ForEach(viewModel.favorites, id: \.id) { favorite in
                HStack(spacing: 15) {
                    favoriteTypeIcon(favorite.type)
                    
                    NotificationCell(favorite: favorite)
                        .onTapGesture {
                            openURL(favorite.url)
                        }
                }
            }
            .onDelete { indices in
                viewModel.delete(at: indices)
            }
        }
    }
    
    var fetchFailed: some View {
        VStack(spacing: 30) {
            Image(systemName: "star.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            Text("등록된 즐겨찾기가 없습니다.\n\n공지를 스와이프하여 즐겨찾기를 추가해보세요!")
                .multilineTextAlignment(.center)
        }
    }
    
    func favoriteTypeIcon(_ type: String) -> some View {
        if type == "KW_HOME" {
            return Image(systemName: "graduationcap.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(.accentColor)
        } else {
            return Image(systemName: "s.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(.blue)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        DependencyContainer.shared.register(type: FavoriteNoticeDataStoreProtocol.self) { _ in
            LocalFavoriteNoticeDataStore()
        }
        DependencyContainer.shared.register(type: FavoriteNoticeRepositoryProtocol.self) { r in
            FavoriteNoticeRepository(dataStore: r.resolve())
        }
        return FavoriteView()
    }
}
