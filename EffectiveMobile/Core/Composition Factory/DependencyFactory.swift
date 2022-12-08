//
//  DependencyFactory.swift
//  EffectiveMobile
//
//  Created by Alexandr on 08.12.2022.
//

import Foundation

class DependencyFactory {
    // MARK: Subtypes
    struct InstanceKey: Hashable, CustomStringConvertible {
        let name: String
        
        var description: String {
            return "shared function \(name)"
        }
        
        static func == (lhs: InstanceKey, rhs: InstanceKey) -> Bool {
            return lhs.name == rhs.name
        }
    }
    
    // MARK: Properties
    private var instanceStack: [InstanceKey] = []
    private var sharedInstances: [String: Any] = [:]
    
    // MARK: Initializers
    init() {}
    
    // MARK: Factory
    func shared<T>(name: String = #function, _ factory: @autoclosure () -> T) -> T {
        if let instance = sharedInstances[name] as? T {
            return instance
        }
        
        return inject(
            name: name,
            factory: factory
        )
    }
    
    private func inject<T>(
        name: String,
        factory: () -> T
    ) -> T {
        let key = InstanceKey(name: name)
        let instance = factory()
        sharedInstances[name] = instance
        
        return instance
    }
}
