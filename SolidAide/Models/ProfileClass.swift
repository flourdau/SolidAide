//
//  ProfileClass.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import Foundation
import SwiftData
import MapKit

@Model
class ProfileClass: Identifiable {
    var userId: UserClass?
    var pseudo: String
    var city: String? = nil
    var birthday: Date? = nil
// ADD var isOnline pour la messagerie
    @Attribute private var userQualityRawValues: [String]? = nil
    var userQuality: [UserQualityEnum]? {
        get { return userQualityRawValues?.compactMap { UserQualityEnum(rawValue: $0) } }
        
        set { userQualityRawValues = newValue? .map { $0.rawValue } }
        
    }

    var imageURL: String? = nil
    var aboutMe: String? = nil
    var positionData: GPSCoordinateStruct? = nil
    var userPosition: CLLocationCoordinate2D? {
        get {
            if let lat = positionData?.latitude, let lon = positionData?.longitude {
                return CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return nil
        }
        set {
            self.positionData = newValue != nil ? GPSCoordinateStruct(coordinate: newValue) : nil
        }
    }

    @Attribute private var skillsRawValues: [String]? = nil
    var skills: [SkillsEnum]? {
        get { return skillsRawValues?.compactMap { SkillsEnum(rawValue: $0) } }
        
        set { skillsRawValues = newValue?.map { $0.rawValue } }

    }

    var availability: String? = nil
    var contacts: [UserClass]? = nil
    var favorite: [UserClass]? = nil
    var chats: [ChatClass]? = nil
    var helper: [UserClass]? = nil
    var beneficiary: [UserClass]? = nil

    init(
        userId: UserClass? = nil,
        pseudo: String,
        city: String? = nil,
        birthday: Date? = nil,
        userQuality: [UserQualityEnum]? = nil,
        imageURL: String? = nil,
        aboutMe: String? = nil,
        userPosition: CLLocationCoordinate2D? = nil,
        skills: [SkillsEnum]? = nil,
        availability: String? = nil,
        contacts: [UserClass]? = nil,
        favorite: [UserClass]? = nil,
        chats: [ChatClass]? = nil,
        helper: [UserClass]? = nil,
        beneficiary: [UserClass]? = nil
    ) {
        self.userId = userId
        self.pseudo = pseudo
        self.city = city
        self.birthday = birthday
        self.userQualityRawValues = userQuality?.map { $0.rawValue }
        self.imageURL = imageURL
        self.aboutMe = aboutMe
        self.userPosition = userPosition
        self.skillsRawValues = skills?.map { $0.rawValue }
        self.availability = availability
        self.contacts = contacts
        self.favorite = favorite
        self.chats = chats
        self.helper = helper
        self.beneficiary = beneficiary
    }
}
