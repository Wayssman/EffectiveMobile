//
//  CompositionFactory.swift
//  EffectiveMobile
//
//  Created by Alexandr on 08.12.2022.
//

import Foundation

var Core = CompositionFactory.shared.core
var Service = CompositionFactory.shared.service

final class CompositionFactory: DependencyFactory {
    // MARK: Singleton
    static let shared = CompositionFactory()
    
    // MARK: Properties
    var core: CoreFactory {
        shared(CoreFactory())
    }
    var service: ServiceFactory {
        shared(ServiceFactory())
    }
    
    // MARK: Initializers
    private override init() {
        super.init()
    }
}
