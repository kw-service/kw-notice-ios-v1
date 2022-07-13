//
//  FavoriteView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI
import KWNoticeKit

struct FavoriteView: View {
    
    @StateObject var viewModel = FavoriteViewModel()
    @State private var editMode: EditMode = .inactive
    @State private var searchText = ""
    
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
    }
    
    @ViewBuilder var contentView: some View {
        switch viewModel.state {
            case .noContent:
                fetchFailed
            case .fetched:
                favoritesList
            case .error:
                PlaceholderView {
                    viewModel.fetch()
                }
        }
    }
    
    var favoritesList: some View {
        List {
            ForEach(viewModel.favorites, id: \.id) { favorite in
                favoriteCell(favorite)
            }
            .onDelete { indices in
                if viewModel.favorites.count == 1 {
                    editMode = .inactive
                }
                viewModel.delete(at: indices)
            }
        }
        .listStyle(.plain)
        .environment(\.editMode, $editMode)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "즐겨찾기 검색"
        )
        .toolbar {
            editButton
        }
        .onChange(of: searchText) { newValue in
            viewModel.search(newValue)
        }
    }
    
    var fetchFailed: some View {
        VStack(spacing: 30) {
            Image(systemName: "star.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            Text("등록된 즐겨찾기가 없습니다.")
        }
    }
    
    func favoriteCell(_ favorite: Favorite) -> some View {
        HStack(spacing: 15) {
            favoriteTypeIcon(favorite.type)

            VStack(alignment: .leading, spacing: 10) {
                Text(favorite.title)
                    .bold()
                    .lineLimit(1)
                
                Text("작성일 \(favorite.postedDate.toString())")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
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
    
    var editButton: some View {
        return Button(editMode == .inactive ? "편집" : "완료") {
            editMode = (editMode == .inactive) ? .active : .inactive
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
