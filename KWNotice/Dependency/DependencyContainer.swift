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
    
    func register<T>(_ resolver: (DependencyContainer) -> T) {
        let instance = resolver(self)
        dependencies[getKey(of: T.self)] = instance
    }
    
    func resolve<T>() -> T? {
        guard let instance = dependencies[getKey(of: T.self)] as? T else {
            print("dependency container: cannot find instance of type \(T.self).")
            return nil
        }
        return instance
    }
}

@propertyWrapper
class Inject<T> {
    
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = DependencyContainer.shared.resolve() ?? wrappedValue
    }
}
