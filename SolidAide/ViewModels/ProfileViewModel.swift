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
    var pseudo: String = ""
    var city: String = ""
    var birthday: Date = Date()
    var aboutMe: String = ""
    var latitudeString: String = ""
    var longitudeString: String = ""
    private var editingProfile: ProfileClass?
    
    init() {}
    
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
        guard !pseudo.isEmpty else {
            print("Le pseudo ne peut pas être vide.")
            return
        }
        
        let lat = Double(latitudeString)
        let lon = Double(longitudeString)
        var newPosition: CLLocationCoordinate2D? = nil
        
        if let lat, let lon {
            newPosition = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        if let editingProfile {
            editingProfile.pseudo = pseudo
            editingProfile.city = city.isEmpty ? nil : city
            editingProfile.birthday = birthday
            editingProfile.aboutMe = aboutMe.isEmpty ? nil : aboutMe
            editingProfile.profilePosition = newPosition
            
            print("Profil mis à jour: \(editingProfile.pseudo)")
            
        } else {
            let newProfile = ProfileClass(
                pseudo: pseudo,
                city: city.isEmpty ? nil : city,
                birthday: birthday,
                aboutMe: aboutMe.isEmpty ? nil : aboutMe,
                profilePosition: newPosition
            )
            
            context.insert(newProfile)
            print("Nouveau profil créé: \(newProfile.pseudo)")
        }
    }
}
