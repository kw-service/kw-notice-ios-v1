//
//  KWNoticeApp.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI
import KWNoticeKit

@main
struct KWNoticeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var topicSubscriber = TopicSubscriber()
    
    init() {
        configureDependency()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(topicSubscriber)
        }
    }
}

extension KWNoticeApp {
    func configureDependency() {
        configureNoticeDependency()
    }
    
    func configureNoticeDependency() {
        configureKWHomeDependency()
        configureSWCentralDependency()
    }
    
    func configureKWHomeDependency() {
        DependencyContainer.shared.register(type: KWHomeDataStoreProtocol.self) { _ in
            KWHomeDataStore()
        }
        
        DependencyContainer.shared.register(type: KWHomeRepositoryProtocol.self) { r in
            KWHomeRepository(dataStore: r.resolve() ?? KWHomeDataStore())
        }
    }
    
    func configureSWCentralDependency() {
        DependencyContainer.shared.register(type: SWCentralDataStoreProtocol.self) { _ in
            SWCentralDataStore()
        }
        
        DependencyContainer.shared.register(type: SWCentralRepositoryProtocol.self) { r in
            SWCentralRepository(dataStore: r.resolve() ?? SWCentralDataStore())
        }
    }
}
