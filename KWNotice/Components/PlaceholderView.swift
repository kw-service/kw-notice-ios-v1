//
//  PlaceholderView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/08.
//

import SwiftUI

struct PlaceholderView: View {
    
    let navigationTitle: String
    var reloadAction: () async -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Button(
                action: {
                    Task {
                        await reloadAction()
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
            )
            Text("공지가 없습니다.")
                .font(.title2)
            Text("계속해서 해당 화면이 보일 경우, \n[설정 - 앱 정보 - 개발 및 피드백]에 \n적혀 있는 연락처로 문의해 주세요.")
                .multilineTextAlignment(.center)
        }
        .navigationTitle(navigationTitle)
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(navigationTitle: "") {
            
        }
    }
}
