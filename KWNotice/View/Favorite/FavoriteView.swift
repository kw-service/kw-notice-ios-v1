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
                viewModel.delete(at: indices)
            }
        }
        .listStyle(.plain)
        .toolbar {
            EditButton()
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
