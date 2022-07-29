//
//  SettingView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - Properties
    @EnvironmentObject var topicSubscriber: TopicSubscriber
    @Environment(\.scenePhase) var scenePhase
    @AppStorage(Setting.useExternalBrowser) var useExternalBrowser = false
    
    @State var isNotificationGranted = false
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            List {
                if !isNotificationGranted {
                    permissionNotGrantedView
                }
                Section(
                    content: kwNotificationSettings,
                    header: kwNotificationHeader
                )
                
                Section(
                    content: swNotificationSettings,
                    header: swNotificationHeader
                )
                
                Section(
                    content: appSettings,
                    header: appSettingsHeader
                )
                
                Section(
                    content: appInformation,
                    header: appInformationHeader
                )
                
#if DEBUG
                Section(
                    content: {
                        NavigationLink("DEV - Saved Notifications") {
                            SavedNotificationView()
                        }
                    },
                    header: {
                        Text("Develop")
                            .foregroundColor(.blue)
                    }
                )
#endif
            }
            .navigationTitle("설정")
//            .listStyle(.plain)
        }
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                updateIsNotificationGranted { isNotificationGranted in
                    withAnimation {
                        self.isNotificationGranted = isNotificationGranted
                    }
                }
            }
        }
    }
}

extension SettingView {
    // MARK: - Permission
    func updateIsNotificationGranted(_ completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                let isNotificationGranted = (settings.authorizationStatus == .authorized)
                completion(isNotificationGranted)
            }
        }
    }
    
    var permissionNotGrantedView: some View {
        HStack {
            Text(permissionNotGrantedMessage)
                .font(.callout)
            
            Spacer()
            
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(.accentColor)
        }
        .onTapGesture {
            if let appSettingURL = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(appSettingURL) {
                UIApplication.shared.open(appSettingURL)
            }
        }
    }
    
    var permissionNotGrantedMessage: LocalizedStringKey {
        let linkedMessage = "알림이 허용되어 있지 않습니다.\nKW 알리미 설정에서 알림을 허용해주세요."

        return LocalizedStringKey(linkedMessage)
    }
    
    // MARK: - KW Notification
    @ViewBuilder
    func kwNotificationSettings() -> some View {
        Toggle("새로운 공지사항 알림", isOn: $topicSubscriber.kwNewNotice)
            .disabled(!isNotificationGranted)
        
        Toggle("기존 공지사항 수정 알림", isOn: $topicSubscriber.kwEditNotice)
            .disabled(!isNotificationGranted)
    }
    
    func kwNotificationHeader() -> some View {
        Text("광운대학교 알림")
            .foregroundColor(.accentColor)
    }
    
    // MARK: - SW Notification
    @ViewBuilder
    func swNotificationSettings() -> some View {
        Toggle("새로운 공지사항 알림", isOn: $topicSubscriber.swNewNotice)
            .disabled(!isNotificationGranted)
    }
    
    func swNotificationHeader() -> some View {
        Text("SW중심대학산업단 알림")
            .foregroundColor(.accentColor)
    }
    
    // MARK: - App Setting
    @ViewBuilder
    func appSettings() -> some View {
        Toggle(isOn: $useExternalBrowser) {
            VStack(alignment: .leading, spacing: 10) {
                Text("외부 브라우저 사용")
                Text(getSubtitleForUseExternalBrowser())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func getSubtitleForUseExternalBrowser() -> String {
        let externalBrowserUsed = "공지사항을 터치하면 사파리 및 크롬 등의 외부 브라우저로 연결됩니다."
        let internalBrowserUsed = "공지사항을 터치하면 앱 내에서 브라우저가 열립니다."
        return useExternalBrowser ? externalBrowserUsed : internalBrowserUsed
    }
    
    func appSettingsHeader() -> some View {
        Text("앱 설정")
            .foregroundColor(.accentColor)
    }
    
    // MARK: - App Information
    @ViewBuilder
    func appInformation() -> some View {
        Link(destination: Setting.githubURL, label: developAndFeedback)
        Link(destination: Setting.appStoreURL, label: version)
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
        Group {
            SettingView()
            SettingView()
                .preferredColorScheme(.dark)
        }
    }
}
