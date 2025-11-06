//
//  SplashScreen.swift
//  SolidAide
//
//  Created by apprenant78 on 06/11/2025.
//

import SwiftUI

struct SplashScreen: View {
    // Animation simple : le logo apparaît, grossit légèrement puis disparaît
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            // Fond uni (noir ou blanc, à vous de choisir)
            Color.goldenYellow
                .ignoresSafeArea()

            // Logo – ici on utilise exactement le nom de votre image Asset : "AppIcon"
            Image("LogoSolidAide")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .onAppear {
            // 1️⃣  Fade‑in + légère agrandissement
            withAnimation(.easeOut(duration: 0.8)) {
                self.scale = 1.0
                self.opacity = 1.0
            }

            // 2️⃣  Après 1.5 s, on fait disparaître le logo
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeIn(duration: 0.4)) {
                    self.opacity = 0.0
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
