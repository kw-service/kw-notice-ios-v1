//
//  NoSearchResultView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/29.
//

import SwiftUI

struct NoSearchResultView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            
            Text("검색 결과가 없습니다.")
                .bold()
                .font(.title3)
        }
    }
}

struct NoSearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoSearchResultView()
    }
}
