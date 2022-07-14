//
//  SafariView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/14.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    // MARK: - Properties
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        return
    }
}
