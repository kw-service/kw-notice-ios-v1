//
//  KWNoticeApp.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI

@main
struct KWNoticeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
