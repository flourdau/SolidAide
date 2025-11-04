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
    @State private var currentProfileModel: CurrentProfileModel

    init() {
        let container = try! ModelContainer(for: ProfileClass.self)
        _currentProfileModel = State(initialValue: CurrentProfileModel(context: container.mainContext))
    }

    var body: some Scene {
        WindowGroup {
            SolidAideView()
                .environment(currentProfileModel)
        }
        .modelContainer(for: [
            UserClass.self,
            ProfileClass.self,
            ServiceClass.self,
            ChatClass.self,
            TimeBankEntry.self
        ])
    }
}
