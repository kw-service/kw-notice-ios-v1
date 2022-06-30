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
                Section(
                    content: kwNotificationSettings,
                    header: kwNotificationHeader
                )
                
                Section(
                    content: swNotificationSettings,
                    header: swNotificationHeader
                )
                
                Section(
                    content: appInformation,
                    header: appInformationHeader
                )
            }
            .navigationTitle("설정")
            .listStyle(.inset)
        }
    }
}

extension SettingView {
    // MARK: - KW Notification
    @ViewBuilder
    func kwNotificationSettings() -> some View {
        Toggle("새로운 공지사항 알림", isOn: $kwNewNotice)
        Toggle("기존 공지사항 수정 알림", isOn: $kwEditNotice)
    }
    
    func kwNotificationHeader() -> some View {
        Text("광운대학교 알림")
            .foregroundColor(.accentColor)
    }
    
    // MARK: - SW Notification
    @ViewBuilder
    func swNotificationSettings() -> some View {
        Toggle("새로운 공지사항 알림", isOn: $swNewNotice)
    }
    
    func swNotificationHeader() -> some View {
        Text("SW중심대학산업단 알림")
            .foregroundColor(.accentColor)
    }
    
    // MARK: - App Information
    @ViewBuilder
    func appInformation() -> some View {
        NavigationLink(
            destination: {},
            label: developAndFeedback
        )
        
        NavigationLink(
            destination: {},
            label: version
        )
    }
    
    func developAndFeedback() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("개발 및 피드백")
            Text(verbatim: "yy0867@gmail.com")
                .foregroundColor(.gray)
                .font(.caption)
        }
    }
    
    func version() -> some View {
        Text("버전 1.0.0")
    }
    
    func appInformationHeader() -> some View {
        Text("앱 정보")
            .foregroundColor(.accentColor)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
