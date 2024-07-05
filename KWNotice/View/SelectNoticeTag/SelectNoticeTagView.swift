//
//  SelectNoticeTypeView.swift
//  KWNotice
//
//  Created by 장석우 on 6/14/24.
//

import SwiftUI
import SafariServices
import KWNoticeKit

struct SelectNoticeTagView: View {
    
    @StateObject var viewModel = SelectNoticeTagViewModel()
    
    @Binding var selectedNoticeTag: String
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .none:
                noticeTagList
            case .fetching:
                ProgressView()
            case .error:
                PlaceholderView(navigationTitle: "") {
                    viewModel.refresh()
                }
            }
        }
        .task { viewModel.fetch() }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isPresented) {
            Button("확인") {}
        }
        .navigationViewStyle(.stack)
    }
    
    var noticeTagList: some View {
        List {
            ForEach(viewModel.tags, id: \.self ) { tag in
                NoticeTagCell(title: tag, selectedNoticeTag: $selectedNoticeTag)
            }
        }
        .listStyle(.plain)
        
    }
    
}

struct SelectNoticeTypeView_Previews: PreviewProvider {
    static var previews: some View {
        return KWHomeNoticeView()
    }
}
