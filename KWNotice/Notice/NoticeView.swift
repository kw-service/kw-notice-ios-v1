//
//  NoticeView.swift
//  KWNotice
//
//  Created by 김세영 on 2022/06/30.
//

import SwiftUI

struct NoticeView: View {
    
    enum Views: String, Identifiable {
        case kwHome = "광운대학교"
        case swCentral = "SW중심대학사업단"
        var id: Self { self }
    }
    
    @State private var presentedView: Views = .kwHome
    
    init() {
        UISegmentedControl.appearance().backgroundColor = .tertiarySystemBackground
    }
    
    var body: some View {
        ZStack() {
            contentView()
        }
        .overlay(viewPicker, alignment: .bottom)
    }
    
    func contentView() -> AnyView {
        switch presentedView {
            case .kwHome:
                return AnyView(KWHomeNoticeView())
            case .swCentral:
                return AnyView(Text("SW Central"))
        }
    }
    
    var viewPicker: some View {
        Picker("picker", selection: $presentedView) {
            Text(Views.kwHome.rawValue).tag(Views.kwHome)
            Text(Views.swCentral.rawValue).tag(Views.swCentral)
        }
        .opacity(1)
        .pickerStyle(.segmented)
        .padding()
        .shadow(color: .gray.opacity(0.5), radius: 3, x: 2, y: 2)
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
