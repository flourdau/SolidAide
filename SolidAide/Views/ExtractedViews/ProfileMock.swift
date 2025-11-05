/*
  __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
|     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
                                       (|                      (|
*/
import Foundation
import CoreLocation

extension ProfileClass {
    static var mock: ProfileClass {
        ProfileClass(
            pseudo: "Jean Dupont",
            city: "Paris",
            birthday: Date(timeIntervalSince1970: 631152000),
            aboutMe: "Développeur passionné par SwiftUI et l’IA.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
            skills: [.cooking, .digital, .DIY]
        )
    }
}
