//
//  ModelContextDeleteAll.swift
//  SolidAide
//
//  Created by Apprenant 78 on 05/11/2025.
//

import SwiftData

extension ModelContext {
    /// Supprime toutes les instances d’un type persistant.
    /// - Parameter type: Le type de modèle à vider.
    func deleteAll<T: PersistentModel>(of type: T.Type) throws {
        let descriptor = FetchDescriptor<T>()
        let objects = try fetch(descriptor)
        for obj in objects { delete(obj) }
    }
}
