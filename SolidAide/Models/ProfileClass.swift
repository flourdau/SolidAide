//
//  ProfileClass.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import Foundation
import SwiftData

@Model
class ProfileClass: Identifiable {
    var userId: UserClass
    var pseudo: String
    var city: String? = nil
    var birthday: Date? = nil
    @Attribute private var userQualityRawValues: [String]? = nil
    var userQuality: [UserQualityEnum]? {
        get { return userQualityRawValues?.compactMap { UserQualityEnum(rawValue: $0) } }
        
        set { userQualityRawValues = newValue? .map { $0.rawValue } }
        
    }
    var imageURL: String? = nil
    var aboutMe: String? = nil
    var position: GPSCoordinateStruct? = nil
    @Attribute private var skillsRawValues: [String]? = nil
    var skills: [SkillsEnum]? {
        get {  return skillsRawValues?.compactMap { SkillsEnum(rawValue: $0) } }
        
        set { skillsRawValues = newValue?.map { $0.rawValue } }

    }
    var availability: String? = nil
    var contacts: [UserClass]? = nil
    var favorite: [UserClass]? = nil
    var chats: [ChatClass]? = nil
    var helper: [UserClass]? = nil
    var beneficiary: [UserClass]? = nil

    init(
        userId: UserClass,
        pseudo: String,
        city: String? = nil,
        birthday: Date? = nil,
        userQuality: [UserQualityEnum]? = nil,
        imageURL: String? = nil,
        aboutMe: String? = nil,
        position: GPSCoordinateStruct? = nil,
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
        self.position = position
        self.skillsRawValues = skills?.map { $0.rawValue }
        self.availability = availability
        self.contacts = contacts
        self.favorite = favorite
        self.chats = chats
        self.helper = helper
        self.beneficiary = beneficiary
    }
}
