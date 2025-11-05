import Foundation
import SwiftData
import Combine
import MapKit
final class ProfileViewModel: ObservableObject {
    @Published var pseudo: String = ""
    @Published var city: String = ""
    @Published var aboutMe: String = ""
    @Published var birthday: Date = Date()
    @Published var latitudeString: String = ""
    @Published var longitudeString: String = ""
    @Published var selectedSkills: Set<SkillsEnum> = []

    init() {}

    init(profile: ProfileClass) {
        pseudo = profile.pseudo
        city = profile.city ?? ""
        aboutMe = profile.aboutMe ?? ""
        birthday = profile.birthday ?? Date()
        if let coord = profile.profilePosition {
            latitudeString = String(coord.latitude)
            longitudeString = String(coord.longitude)
        }
        selectedSkills = Set(profile.skills ?? [])
    }

    func save(to context: ModelContext) {
        let existing: ProfileClass? = {
            let descriptor = FetchDescriptor<ProfileClass>(predicate: #Predicate { $0.pseudo == pseudo })
            return try? context.fetch(descriptor).first
        }()

        let profile = existing ?? ProfileClass(
            pseudo: pseudo,
            city: city,
            birthday: birthday,
            aboutMe: aboutMe,
            profilePosition: nil,
            skills: Array(selectedSkills)
        )

        profile.pseudo = pseudo
        profile.city = city
        profile.aboutMe = aboutMe
        profile.birthday = birthday

        if let lat = Double(latitudeString), let lon = Double(longitudeString) {
            profile.profilePosition = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }

        profile.skills = Array(selectedSkills)

        try? context.save()
    }
}
