//
//  SolidAideApp.swift
//  SolidAide
//
//  Created by apprenant78 on 27/10/2025.
//

import SwiftUI
import SwiftData

@main
struct SolidAideApp: App {
    
    var body: some Scene {
        WindowGroup {
            SolidAideView()
                .modelContainer(for: [
                    UserClass.self,
                    ProfileClass.self,
                    ChatClass.self,
                    ServiceClass.self,
                    TimeBankClass.self
                ])
        }
        .modelContainer(for: [
            UserClass.self,
            ProfileClass.self,
            ChatClass.self,
            ServiceClass.self,
            TimeBankClass.self
        ]) { result in
            if case .success(let container) = result {
                let context = ModelContext(container)
                let descriptor = FetchDescriptor<ProfileClass>()
                if let count = try? context.fetchCount(descriptor), count == 0 {
                    GenerateDataBaseFunc(context: context)
                    try? context.save()
                }
            }
        }
    }
}
