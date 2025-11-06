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
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.easeOut) {
                                showSplash = false
                            }
                        }
                    }
            } else {
                SolidAideView()
                    .modelContainer(for: [
                        UserClass.self,
                        ProfileClass.self,
                        ChatClass.self,
                        ServiceClass.self,
                        TimeBankClass.self
                    ])            }
            
        }
    }
}
