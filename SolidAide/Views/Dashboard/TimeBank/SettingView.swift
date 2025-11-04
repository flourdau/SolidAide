//
//  SettingsView.swift
//  SolidAide
//
//  Created by Apprenant 78 on 29/10/2025.
//

import SwiftUI


enum AppFont: String, CaseIterable, Identifiable {
    case system   = "System"
    case luciole  = "Luciole"
    case openDys  = "OpenDyslexic"

    var id: String { rawValue }
}


struct SettingsView: View {

    @AppStorage("selectedFont") private var selectedFontRaw = AppFont.system.rawValue

    private var selectedFont: Binding<AppFont> {
        // ... (votre Binding reste le même)
        Binding<AppFont>(
             get: { AppFont(rawValue: selectedFontRaw) ?? .system },
             set: { newValue in selectedFontRaw = newValue.rawValue }
         )
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Police d’affichage")) { // Texte de la section est naturellement en gras

                    Picker("Choisissez votre police", selection: selectedFont) {
                        ForEach(AppFont.allCases) { font in
                            Text(font.rawValue).tag(font)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            // 1. Appliquer la police par défaut (Regular)
            .applyAppFont(18)
            
            // 2. Surcharger le titre de navigation pour qu'il soit Bold
            .navigationTitle("Paramètres")
            .font(.custom("Luciole-Bold", size: 24)) // L'ancienne méthode ne fonctionne pas avec applyAppFont

            // --- Solution améliorée ---
            // Le .navigationTitle ne peut pas être modifié par applyAppFont directement de cette façon.
            // On peut encadrer le texte de la navigationView pour appliquer le .bold
        }
        // Solution plus robuste : Appliquer le style au niveau du NavigationView et laisser l'héritage faire le travail
        .applyAppFont(18)
        
        // Pour garantir que les titres soient en Gras, nous devons souvent les cibler individuellement
        // ou utiliser une vue personnalisée pour le titre. Pour la NavigationView,
        // c'est complexe. Concentrons-nous sur le texte dans la Form et le Section:
        .fontWeight(.bold) // Ceci forcera applyAppFont à utiliser la variante Bold pour les éléments par défaut en gras
    }
}

// MARK: - Preview (facultatif, pratique pour Xcode)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
