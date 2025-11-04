//
//  ProfileViewModel.swift
//  SolidAide
//
//  Created by apprenant78 on 04/11/2025.
//

// ProfileViewModel.swift
import Foundation
import SwiftData
import MapKit

@Observable
class ProfileViewModel {
    
    // Propriétés pour le formulaire
    var pseudo: String = ""
    var city: String = ""
    var birthday: Date = Date()
    var aboutMe: String = ""
    var latitudeString: String = ""
    var longitudeString: String = ""
    
    // Stocke une référence au profil en cours de modification
    // C'est 'nil' s'il s'agit d'une création
    private var editingProfile: ProfileClass?

    // Initialiseur pour la création (formulaire vide)
    init() {}
    
    // Initialiseur pour la mise à jour (pré-remplit le formulaire)
    init(profile: ProfileClass) {
        self.editingProfile = profile
        
        self.pseudo = profile.pseudo
        self.city = profile.city ?? ""
        self.birthday = profile.birthday ?? Date()
        self.aboutMe = profile.aboutMe ?? ""
        
        if let coordinate = profile.profilePosition {
            self.latitudeString = String(coordinate.latitude)
            self.longitudeString = String(coordinate.longitude)
        }
    }
    
    /// Sauvegarde les modifications dans le ModelContext
    func save(context: ModelContext) {
        // Validation simple
        guard !pseudo.isEmpty else {
            print("Le pseudo ne peut pas être vide.")
            return
        }
        
        // Convertir les coordonnées
        let lat = Double(latitudeString)
        let lon = Double(longitudeString)
        var newPosition: CLLocationCoordinate2D? = nil
        
        if let lat, let lon {
            newPosition = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }

        if let editingProfile {
            // --- UPDATE ---
            // Modifie le profil existant
            editingProfile.pseudo = pseudo
            editingProfile.city = city.isEmpty ? nil : city
            editingProfile.birthday = birthday
            editingProfile.aboutMe = aboutMe.isEmpty ? nil : aboutMe
            editingProfile.profilePosition = newPosition
            
            print("Profil mis à jour: \(editingProfile.pseudo)")
            
        } else {
            // --- CREATE ---
            // Crée un nouveau profil
            let newProfile = ProfileClass(
                pseudo: pseudo,
                city: city.isEmpty ? nil : city,
                birthday: birthday,
                aboutMe: aboutMe.isEmpty ? nil : aboutMe,
                profilePosition: newPosition
            )
            
            // Insère le nouveau profil dans le contexte
            context.insert(newProfile)
            print("Nouveau profil créé: \(newProfile.pseudo)")
        }
        
        // SwiftData sauvegarde automatiquement les modifications du contexte
        // (généralement lorsque la scène se ferme ou que l'app va en arrière-plan)
    }
}
