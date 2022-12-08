//
//  CoreFactory.swift
//  EffectiveMobile
//
//  Created by Alexandr on 08.12.2022.
//

import Foundation

extension CompositionFactory {
    final class CoreFactory: DependencyFactory {
        var networkService: NetworkServiceInterface {
            return shared(NetworkService())
        }
        var storageService: StorageInterface {
            return shared(RealmStorage())
        }
    }
}
