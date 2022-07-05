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
    
    var body: some View {
        VStack {
            Picker("picker", selection: $presentedView) {
                Text(Views.kwHome.rawValue).tag(Views.kwHome)
                Text(Views.swCentral.rawValue).tag(Views.swCentral)
            }
            .pickerStyle(.segmented)
            .padding()
            
            contentView()
        }
    }
    
    func contentView() -> AnyView {
        switch presentedView {
            case .kwHome:
                return AnyView(KWHomeNoticeView())
            case .swCentral:
                return AnyView(Text("SW Central"))
        }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView()
    }
}
