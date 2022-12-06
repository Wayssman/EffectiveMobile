//
//  RealmStorage.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import Foundation
import RealmSwift

protocol StorageInterface {
    func save(object: Object) throws
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate?) -> [T]
    func deleteAll<T: Object>(_ model: T.Type, where predicate: NSPredicate?) throws
}

final class RealmStorage {
    // MARK: Properties
    private let schemaVersion: UInt64 = 1
    private var realm: Realm? {
        tryRealm()
    }
    
    
    // MARK: Internal
    private func tryRealm() -> Realm? {
        let configuration = Realm.Configuration(
            schemaVersion: schemaVersion
        ) { [weak self] (migration, oldSchemaVersion) in
            self?.migrationBlock(migration: migration, oldSchemaVersion: oldSchemaVersion)
        }

        guard let folderPath = configuration.fileURL?.deletingLastPathComponent().path else {
            return nil
        }

        Realm.Configuration.defaultConfiguration = configuration

        do {
            let key = FileAttributeKey.protectionKey
            try FileManager.default.setAttributes([key: FileProtectionType.none], ofItemAtPath: folderPath)
            
            let realm = try Realm()
            return realm
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
    
    private func migrationBlock(migration: Migration, oldSchemaVersion: UInt64) {
        // TODO: Add migration changes if needed
    }
}

// MARK: - StorageInterface
extension RealmStorage: StorageInterface {
    func save(object: Object) throws {
        try realm?.write {
            realm?.add(object)
        }
    }
    
    func fetch<T: Object>(_ model: T.Type, predicate: NSPredicate? = nil) -> [T] {
        guard let realm = realm else {
            assertionFailure("Failed to open Realm storage")
            return []
        }
        
        var objects = realm.objects(model)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        return objects.compactMap{ $0 }
    }
    
    func deleteAll<T: Object>(_ model: T.Type, where predicate: NSPredicate? = nil) throws {
        var objects = realm?.objects(model)
        if let predicate = predicate {
            objects = objects?.filter(predicate)
        }
        
        guard let objects = objects else { return }
        try realm?.write {
            realm?.delete(objects)
        }
    }
}
