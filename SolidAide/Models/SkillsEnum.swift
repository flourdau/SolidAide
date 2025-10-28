//
//  SkillsEnum.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import Foundation
import SwiftData

enum SkillsEnum: String, CaseIterable {
    case administrative = "Administratif"
    case pets = "Animaux"
    case DIY = "Bricolage"
    case shopping = "Courses"
    case trainingCourses = "Formation"
    case moving = "Déménagement"
    case sewing = "Couture"
    case digital = "Numérique"
    case cooking = "Cuisine"
    case homeworkSupport = "Scolarité"
    case dogWalk = "Promenade"
    case lending = "Prêt d'objets"
    case carSharing = "Covoiturage"
    case householdTasks = "Tâches ménagères"
    
    var icon : String {
        switch self {
        case.administrative: return "printer.fill"
        case.pets: return "pawprint.circle.fill"
        case.DIY: return "wrench.and.screwdriver"
        case.shopping: return "car.side.rear.open.fill"
        case.trainingCourses: return "book.fill"
        case.moving: return "truck.box.fill"
        case.sewing: return "scissors"
        case.digital: return "display"
        case.cooking: return "frying.pan.fill"
        case.homeworkSupport: return "character.book.closed.fill"
        case.dogWalk: return "dog.fill"
        case.lending: return "shippingbox.fill"
        case.carSharing: return "car.fill"
        case.householdTasks: return "house.fill"
        }
    }
}
