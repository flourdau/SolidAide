//
//  FontExtentions.swift
//  SolidAide
//
//  Created by Apprenant 78 on 29/10/2025.
//

import SwiftUI

extension View {
    
    /*_____________________Nos lucioles :
     
     
     \_/-.--.--.--.--.--.
     (")__)__)__)__)__)__)
     ^ "" "" "" "" "" ""
     
     */
    func lucioleRegular(fontSize: Double) -> some View {
        self
            .font(Font.custom("Luciole-Regular", size: CGFloat(fontSize)))
    }
    
    func lucioleBold(fontSize: Double) -> some View {
        self
            .font(Font.custom("Luciole-Bold", size: CGFloat(fontSize)))
    }
    
    func lucioleItalic(fontSize: Double) -> some View {
        self
            .font(Font.custom("Luciole-Italic", size: CGFloat(fontSize)))
    }
    
    func lucioleBoldItalic(fontSize: Double) -> some View {
        self
            .font(Font.custom("Luciole-BoldItalic", size: CGFloat(fontSize)))
    }
    
    /*____________________________OpenDyslexic
     ⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀
     ⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⣀⡀⠀⠀⠀⠀⠀⠀⠰⣷⣄⠀⠀⠀⠀⠀⣠⣾⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃
     ⠀⠀⠙⢿⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠘⢿⣆⠀⠀⠀⣼⡿⠁⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⣿⠟⠉⠀⠀
     ⠀⠀⠀⠀⠙⢿⣿⣿⣿⣧⡀⠀⠀⠈⠉⠻⢿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠈⢿⣇⠀⣼⡟⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⠿⠛⠉⠀⠀⠀⢠⣾⣿⣿⣿⠟⠁⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠈⠛⢿⣿⣿⣿⣷⣄⠀⠀⠈⣿⣴⡟⠀⠀⠀⣠⣾⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⣰⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣷⡀⠀⢸⣿⠃⠀⢀⣾⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣆⠀⠉⠀⣴⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⡧⢀⣼⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⡟⢁⣾⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢠⣾⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡿⢁⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⡿⢁⣾⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⡟⠀⢾⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⠏⠀⠀⠈⢿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⢀⣠⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣶⣤⣤⣴⣾⣿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣶⣦⣤⣤⣶⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⢿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
     ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
     */
    func openDysBold(fontSize: Double) -> some View {
        self
            .font(Font.custom("OpenDyslexicAlta-Bold.otf", size: CGFloat(fontSize)))
    }
    func openDysBoldItalic(fontSize: Double) -> some View {
        self
            .font(Font.custom("OpenDyslexicAlta-BoldItalic", size: CGFloat(fontSize)))
    }
    func openDysItalic(fontSize: Double) -> some View {
        self
            .font(Font.custom("OpenDyslexicAlta-Italic", size: CGFloat(fontSize)))
    }
    func openDysRegular(fontSize: Double) -> some View {
        self
            .font(Font.custom("OpenDyslexicAlta-Regular", size: CGFloat(fontSize)))
    }
    func openDysMonoRegular(fontSize: Double) -> some View {
        self
            .font(Font.custom("OpenDyslexicMono-Regular", size: CGFloat(fontSize)))
    }
    
    /*
     ______          _
     /\               |  ____|        | |
     /  \   _ __  _ __ | |__ ___  _ __ | |_
     / /\ \ | '_ \| '_ \|  __/ _ \| '_ \| __|
     / ____ \| |_) | |_) | | | (_) | | | | |_
     /_/    \_\ .__/| .__/|_|  \___/|_| |_|\__|
     | |   | |
     |_|   |_|
     */
    
    
    
    // ... toutes vos fonctions spécifiques (lucioleRegular, lucioleBold, etc.) DOIVENT être ici.
    
    // Nouvelle fonction qui sélectionne la bonne variante (Bold ou Regular)
    func applyFont(fontChoice: AppFont, size: Double, weight: Font.Weight = .regular) -> some View {
        // La vue courante est 'self'
        var viewToModify: AnyView
        
        switch fontChoice {
        case .system:
            viewToModify = AnyView(self.font(.system(size: CGFloat(size), weight: weight)))
            
        case .luciole:
            if weight == .bold {
                // Appeler l'extension directement sur self
                viewToModify = AnyView(self.lucioleBold(fontSize: size))
            } else {
                viewToModify = AnyView(self.lucioleRegular(fontSize: size))
            }
            
        case .openDys:
            if weight == .bold {
                viewToModify = AnyView(self.openDysBold(fontSize: size))
            } else {
                viewToModify = AnyView(self.openDysRegular(fontSize: size))
            }
        }
        
        return viewToModify
    }
    
    // La fonction publique qui lit l'état et appelle applyFont
    func applyAppFont(_ size: Double, weight: Font.Weight = .regular) -> some View {
        let stored = UserDefaults.standard.string(forKey: "selectedFont") ?? AppFont.system.rawValue
        let fontChoice = AppFont(rawValue: stored) ?? .system
        
        return self.applyFont(fontChoice: fontChoice, size: size, weight: weight)
    }
}

/*_____________________Nos bouttons :
 ⠀⠀⠀⠀⠀⠀⠀⠀⣠⣀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⡀⢰⠆⣛⣨⣆⣭⠶⡓⠓⠄⠀⠀⠀⠀⠀⠀
 ⠀⠀⠠⣄⣠⠼⢛⣳⢬⣿⣿⣿⣎⡙⣟⠔⢨⣐⡆⠀⠀⠀⠀
 ⠀⠀⠀⢻⣗⡲⣴⣇⣿⣿⣿⣿⣿⣟⡄⠠⢁⣿⠇⠀⠀⠀⠀
 ⠀⢀⣀⣠⣯⡤⣙⣿⣿⣿⣿⣿⣿⣿⡇⢀⢿⡟⠀⠐⠀⡀⡀
 ⠘⢿⣏⡙⢿⣿⣦⣙⣿⣽⢿⣻⣿⣿⣇⠾⠋⠂⠀⠐⢨⡟⠀
 ⠀⠀⠈⠙⠫⠚⢿⠿⠿⠟⠛⠿⠿⡿⠉⠀⠀⣀⠌⠄⠋⠀⠀
 ⠀⠀⠀⠀⠀⠀⠘⣄⠀⠀⠀⢀⡠⠃⡀⠀⠀⠀⡴⠂⠀⠀⠀
 ⠀⠀⠀⠀⠀⠀⠀⠈⠙⠚⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
 */






