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
                .modelContainer(for: UserClass.self)
        }
    }
}
