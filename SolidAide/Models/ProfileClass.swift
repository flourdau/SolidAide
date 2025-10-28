//
//  ProfileClass.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import SwiftUI
import SwiftData

//@Model
class ProfileClass: Identifiable {
    var userId: UserClass
    var pseudo: String
    var birthday: Date
    var userQuality: [UserQualityEnum]
    var imageURL: String
    var aboutMe: String
    var position: GPSCoordinateStruct
    var skills: SkillsEnum
    var availability: String
    var contacts: [UserClass]? = nil
    var favorite: [UserClass]? = nil
    var chats: [ChatClass]? = nil
    
    init(
        userId: UserClass,
        pseudo: String,
        birthday: Date,
        userQuality: [UserQualityEnum],
        imageURL: String,
        aboutMe: String,
        position: GPSCoordinateStruct,
        skills: SkillsEnum,
        availability: String,
        contacts: [UserClass],
        favorite: [UserClass],
        chats: [ChatClass]
    ) {
        self.userId = userId
        self.pseudo = pseudo
        self.birthday = birthday
        self.userQuality = userQuality
        self.imageURL = imageURL
        self.aboutMe = aboutMe
        self.position = position
        self.skills = skills
        self.availability = availability
        self.contacts = contacts
        self.favorite = favorite
        self.chats = chats
    }
}
