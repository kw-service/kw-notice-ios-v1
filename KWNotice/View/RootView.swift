//
//  RootView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            KWHomeNoticeView()
                .tabItem {
                    Image(systemName: "graduationcap.fill")
                    Text("광운대학교")
                }

            SWCentralNoticeView()
                .tabItem {
                    Image(systemName: "s.circle.fill")
                    Text("SW 사업단")
                }

            FavoriteView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("즐겨찾기")
                }

            SettingView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView()
            
            RootView()
                .preferredColorScheme(.dark)
        }
    }
}
