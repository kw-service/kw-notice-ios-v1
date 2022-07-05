//
//  DependencyContainer.swift
//  KWNotice
//
//  Created by 김세영 on 2022/07/04.
//

import Foundation

final class DependencyContainer {
    
    // MARK: - Properties
    static let shared = DependencyContainer()
    private var dependencies = [String: Any]()
    
    // MARK: - Methods
    private init() {}
    
    private func getKey<T>(of type: T.Type) -> String {
        return String(describing: type.self)
    }
    
    func register<T>(type: T.Type, _ resolver: (DependencyContainer) -> T) {
        let instance = resolver(self)
        dependencies[getKey(of: type)] = instance
    }
    
    func resolve<T>() -> T {
        guard let instance = dependencies[getKey(of: T.self)] as? T else {
            preconditionFailure("dependency container: cannot find instance of type \(T.self).")
        }
        return instance
    }
}

@propertyWrapper
class Resolve<T> {
    
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyContainer.shared.resolve()
    }
}
