//
//  SelectNoticeTypeViewModel.swift
//  KWNotice
//
//  Created by 장석우 on 6/14/24.
//

import Foundation
import Combine
import KWNoticeKit

@MainActor
final class SelectNoticeTagViewModel: AlertPublishableObject, ObservableObject {
    
    enum State {
        case none
        case fetching
        case error
    }
    
    // MARK: - Properties
    
    //TODO: DependencyContainer 의 dependencies [String: Any] 에서 가져오기에, Home에서 생성된 KWHomeRepository을 가져온다. (같은 인스턴스 참조)
    @Resolve private var repository: KWHomeRepositoryProtocol
    @Published var tags = ["전체"]
    
    private(set) var state = State.none
    
    // MARK: - Methods
    
    func fetch() {
        state = .fetching
        tags = ["전체"] + repository.getTag() //TODO: Home에서 Notice 데이터 가져오기 전에 getTag를 호출한다면 빈배열이 반환될 것이다.
        state = .none
    }
    
    func refresh() {
        fetch()
    }

}
