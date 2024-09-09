//
//  AlertPublishableObject.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/05.
//

import Foundation

@MainActor
class AlertPublishableObject {
    
    @Published var alertMessage: String = ""
    @Published var isPresented: Bool = false
    
    func sendAlert(with alertMessage: String = "오류가 발생했습니다. 잠시 후 다시 시도해주세요.") {
        self.alertMessage = alertMessage
        self.isPresented = true
    }
}
