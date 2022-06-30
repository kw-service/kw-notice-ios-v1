//
//  SettingView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - Properties
    // this properties are temporary.
    @State private var kwNewNotice: Bool = true
    @State private var kwEditNotice: Bool = true
    @State private var swNewNotice: Bool = true
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    Toggle("새로운 공지사항 알림", isOn: $kwNewNotice)
                    Toggle("기존 공지사항 수정 알림", isOn: $kwEditNotice)
                }, header: {
                    Text("광운대학교 알림")
                        .foregroundColor(.accentColor)
                })
                
                Section(content: {
                    Toggle("새로운 공지사항 알림", isOn: $swNewNotice)
                }, header: {
                    Text("SW중심대학산업단 알림")
                        .foregroundColor(.accentColor)
                })
                
                Section(content: {
                    NavigationLink(destination: {
                        Text("Link")
                    }, label: {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("개발 및 피드백")
                            Text(verbatim: "yy0867@gmail.com")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    })
                    
                    NavigationLink(destination: {
                        Text("Link")
                    }, label: {
                        Text("버전 1.0.0")
                    })
                }, header: {
                    Text("앱 정보")
                        .foregroundColor(.accentColor)
                })
            }
            .navigationTitle("설정")
            .listStyle(.inset)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
