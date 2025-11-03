//
//  GenerateDataFake.swift
//  SolidAide
//
//  Created by apprenant78 on 29/10/2025.
//

import Foundation
import SwiftData
import MapKit
import SwiftUI

func GenerateDataBaseFunc(context: ModelContext) {
    //  USERS
    let users: [UserClass] = [
        UserClass(  // 0
            logIn: "marie.dupont@email.fr",
            password: "password123",
            balance: 1
        ),
        UserClass(  // 1
            logIn: "pierre.martin@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 2
            logIn: "sophie.bernard@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 3
            logIn: "lucas.petit@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 4
            logIn: "emma.durand@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 5
            logIn: "thomas.moreau@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 6
            logIn: "julie.laurent@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass( // 7
            logIn: "antoine.simon@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 8
            logIn: "andrei@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 9
            logIn: "stacy@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 10
            logIn: "severine@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 11
            logIn: "edilene@email.fr",
            password: "password123",
            balance: 5
        ),
        UserClass(  // 12
            logIn: "florian@email.fr",
            password: "password123",
            balance: 5
        )
    ]
    
    //  PROFILES
    let profiles: [ProfileClass] = [
        ProfileClass(
            userId: users[0],
            pseudo: "Marie D.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -35, to: Date()) ?? Date(),
            quality: [.reliableNeighbour, .punctual, .goodCommunication],
            imageURL: "image1.jpg",
            aboutMe: "Professeure de français, j'adore aider mes voisins et partager mes compétences en cuisine. Disponible en soirée et le week-end.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.896347, longitude: 2.345625),
            skills: [.cooking],
            availability: "Lundi-Vendredi: 18h-21h, Week-end: 9h-18h",
            contacts: [users[2], users[4], users[6]],
            favorite: [users[3], users[1], users[7]],
            helper: [users[0]],
            beneficiary: [users[2]]
        ),
        ProfileClass(
            userId: users[1],
            pseudo: "Pierre M.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -42, to: Date()) ?? Date(),
            quality: [.efficient, .reliableNeighbour, .activeMember],
            imageURL: "image2",
            aboutMe: "Bricoleur passionné et retraité. Je propose mes services de bricolage et petits travaux. Très flexible sur les horaires.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.892304, longitude: 2.331346),
            skills: [.DIY],
            availability: "Tous les jours: 8h-20h",
            contacts: [users[3], users[5], users[7]],
            favorite: [users[3], users[5], users[7], users[2], users[4]],
            helper: [users[2]],
            beneficiary: [users[4], users[5]]
        ),
        ProfileClass(
            userId: users[2],
            pseudo: "Sophie B.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -28, to: Date()) ?? Date(),
            quality: [.patient, .verySupportive, .goodCommunication],
            imageURL: "image3",
            aboutMe: "Étudiante en informatique, je peux aider avec les problèmes numériques et donner des cours de soutien scolaire en mathématiques.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.884286, longitude: 2.349548),
            skills: [.digital],
            availability: "Mardi-Jeudi: 14h-19h, Samedi: 10h-16h",
            contacts: [users[0], users[3]],
            helper: [users[2]],
            beneficiary: [users[4], users[5]]
        ),
        ProfileClass(
            userId: users[3],
            pseudo: "Lucas P.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -31, to: Date()) ?? Date(),
            quality: [.punctual, .available, .activeMember],
            imageURL: "image4",
            aboutMe: "Propriétaire d'un chien adorable, je promène volontiers les animaux du quartier. Je peux aussi faire du covoiturage.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.898136, longitude: 2.346827),
            skills: [.dogWalk],
            availability: "Matin: 7h-9h, Soir: 18h-20h",
            contacts: [users[1], users[2], users[4], users[6]]
        ),
        ProfileClass(
            userId: users[4],
            pseudo: "Emma D.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -39, to: Date()) ?? Date(),
            quality: [.goodCommunication, .patient, .verySupportive],
            imageURL: "image5",
            aboutMe: "Maman de trois enfants, j'adore cuisiner et faire les courses. Je peux aider avec les tâches administratives également.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.885704, longitude: 2.359410),
            skills: [.shopping],
            availability: "Lundi-Vendredi: 9h-15h",
            contacts: [users[1], users[3], users[5], users[7]]
        ),
        ProfileClass(
            userId: users[5],
            pseudo: "Thomas M.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -45, to: Date()) ?? Date(),
            quality: [.reliableNeighbour, .efficient, .punctual],
            imageURL: "image6",
            aboutMe: "Expert en déménagement et transport. J'ai un camion et je peux aider pour les gros travaux de déménagement.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.895232, longitude: 2.351775),
            skills: [.moving],
            availability: "Week-end: 8h-19h",
            contacts: [users[1], users[4], users[7]]
        ),
        ProfileClass(
            userId: users[6],
            pseudo: "Julie L.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -26, to: Date()) ?? Date(),
            quality: [.patient, .goodCommunication, .available],
            imageURL: "image7",
            aboutMe: "Couturière professionnelle, je propose des retouches et créations sur mesure. Passionnée par mon métier !",
            profilePosition: CLLocationCoordinate2D(latitude: 48.885332, longitude: 2.334209),
            skills: [.sewing],
            availability: "Mercredi-Samedi: 10h-18h",
            contacts: [users[0], users[3]]
        ),
        ProfileClass(
            userId: users[7],
            pseudo: "Antoine S.",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Formateur en bureautique et gestion. Je donne des formations gratuites aux seniors et débutants. Membre actif depuis 2 ans !",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.trainingCourses],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[1], users[4], users[5]]
        ),
        ProfileClass(
            userId: users[8],
            pseudo: "Andrei",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Développeur Swift 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.DIY, .digital],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[7], users[8], users[9], users[10], users[11]]
        ),
        ProfileClass(
            userId: users[9],
            pseudo: "Stacy",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Développeur Swift 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.DIY, .digital],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[7], users[8], users[9], users[10], users[11]]
        ),
        ProfileClass(
            userId: users[10],
            pseudo: "Severine",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Développeur Swift 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.DIY, .digital],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[7], users[8], users[9], users[10], users[11]]
        ),
        ProfileClass(
            userId: users[11],
            pseudo: "Edilene",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Développeur Swift 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.DIY, .digital],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[7], users[8], users[9], users[10], users[11]]
        ),
        ProfileClass(
            userId: users[12],
            pseudo: "Florian",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Développeur Swift 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.DIY, .digital],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[7], users[8], users[9], users[10], users[11]]
        )
    ]

    //  CHATS
    let chats: [ChatClass] = [
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(),
            sender: users[0],
            recipient: users[1],
            message: "Bonjour Pierre ! Seriez-vous disponible demain pour réparer ma table ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .hour, value: -1, to: Date()) ?? Date(),
            sender: users[1],
            recipient: users[0],
            message: "Bonjour Marie ! Oui bien sûr, je peux passer vers 14h. Ça vous convient ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -45, to: Date()) ?? Date(),
            sender: users[0],
            recipient: users[1],
            message: "Parfait ! À demain alors 😊"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -30, to: Date()) ?? Date(),
            sender: users[2],
            recipient: users[7],
            message: "Bonjour Antoine, je suis intéressée par votre formation Excel !"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -25, to: Date()) ?? Date(),
            sender: users[7],
            recipient: users[2],
            message: "Avec plaisir Sophie ! On commence quand vous voulez. Vous avez déjà des bases ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -20, to: Date()) ?? Date(),
            sender: users[2],
            recipient: users[7],
            message: "Quelques notions seulement. Mercredi après-midi ce serait possible ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -15, to: Date()) ?? Date(),
            sender: users[7],
            recipient: users[2],
            message: "Mercredi 14h c'est parfait ! Je vous envoie mon adresse."
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -10, to: Date()) ?? Date(),
            sender: users[3],
            recipient: users[4],
            message: "Salut Emma ! Tu pourrais me faire des courses cette semaine ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -5, to: Date()) ?? Date(),
            sender: users[4],
            recipient: users[3],
            message: "Salut Lucas ! Oui pas de souci, tu me fais une liste ?"
        ),
        ChatClass(
            dateTime: Calendar.current.date(byAdding: .minute, value: -2, to: Date()) ?? Date(),
            sender: users[5],
            recipient: users[6],
            message: "Bonjour Julie, auriez-vous un créneau cette semaine pour un ourlet de pantalon ?"
        ),
        ChatClass(
            dateTime: Date(),
            sender: users[6],
            recipient: users[5],
            message: "Bonjour Thomas ! Oui, vendredi matin. Apportez le pantalon, je le fais sur place 🪡"
        )
    ]
    
    //  SERVICES
    let services = [
        ServiceClass(
            profileId: profiles[0],
            skill: .cooking,
            serviceDescription: "Cours de cuisine française traditionnelle - Apprenez à préparer un coq au vin et une tarte tatin !",
            city: "Paris",
            isFree: false,
            timeSpent: 3,
            startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        ),
        ServiceClass(
            profileId: profiles[0],
            skill: .digital,
            serviceDescription: "Réparation de petits meubles et montage IKEA. J'apporte mes outils !",
            city: "Paris",
            isFree: false,
            timeSpent: 3,
            startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        ),
        ServiceClass(
            profileId: profiles[2],
            skill: .DIY,
            serviceDescription: "Aide à la configuration d'ordinateur, smartphone, tablette. Installation de logiciels et explications.",
            city: "Paris",
            isFree: false,
            timeSpent: 1,
            startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        ),
        ServiceClass(
            profileId: profiles[3],
            profileIdHelper: profiles[1],
            skill: .dogWalk,
            serviceDescription: "Promenade quotidienne pour votre chien. Je suis habitué aux grands et petits chiens.",
            city: "Paris",
            isFree: false,
            timeSpent: 1,
            startDate: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            serviceRepeat: .everyDay,
            serviceStatus: .finalized,
            isEvaluationCompleted: true,
            isFulfilled: true,
            serviceComment: "Service excellent ! Lucas est très ponctuel et mon chien l'adore."
        ),
        ServiceClass(
            profileId: profiles[4],
            profileIdHelper: profiles[2],
            skill: .shopping,
            serviceDescription: "Courses au supermarché pour personnes à mobilité réduite ou débordées. Je peux livrer chez vous.",
            city: "Paris",
            isFree: false,
            timeSpent: 2,
            startDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
            serviceRepeat: .everyWeek,
            serviceStatus: .awaitingAcceptance,
            isEvaluationCompleted: false,
            isFulfilled: false,
            serviceComment: nil
        ),
        ServiceClass(
            profileId: profiles[5],
            profileIdHelper: profiles[4],
            skill: .moving,
            serviceDescription: "Déménagement complet avec camion 20m³. Aide au chargement et déchargement.",
            city: "Paris",
            isFree: false,
            timeSpent: 6,
            startDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(),
            serviceRepeat: nil,
            serviceStatus: .approved,
            isEvaluationCompleted: false,
            isFulfilled: false,
            serviceComment: nil
        ),
        ServiceClass(
            profileId: profiles[6],
            profileIdHelper: profiles[1],
            skill: .sewing,
            serviceDescription: "Retouches de vêtements : ourlets, fermetures éclair, ajustements. Travail soigné garanti !",
            city: "Paris",
            isFree: false,
            timeSpent: 1,
            startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(),
            serviceRepeat: nil,
            serviceStatus: .awaitingEvaluation,
            isEvaluationCompleted: false,
            isFulfilled: true,
            serviceComment: nil
        ),
        ServiceClass(
            profileId: profiles[6],
            profileIdHelper: profiles[2],
            skill: .trainingCourses,
            serviceDescription: "Formation Word, Excel et PowerPoint pour débutants. Séances individuelles adaptées à votre rythme.",
            city: "Paris",
            isFree: false,
            timeSpent: 2,
            startDate: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(),
            serviceRepeat: ServiceRepeatEnum.everyWeek,
            serviceStatus: ServiceStatusEnum.approved
        ),
        ServiceClass(
            profileId: profiles[0],
            skill: .householdTasks,
            serviceDescription: "Ménage complet : aspirateur, serpillère, dépoussiérage. Produits écologiques fournis.",
            city: "Paris",
            isFree: false,
            timeSpent: 3,
            startDate: Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date(),
            serviceRepeat: ServiceRepeatEnum.everyWeek
        ),
        ServiceClass(
            profileId: profiles[2],
            profileIdHelper: profiles[1],
            skill: .homeworkSupport,
            serviceDescription: "Soutien scolaire en mathématiques niveau collège et lycée. Préparation aux examens.",
            city: "Paris",
            isFree: false,
            timeSpent: 2,
            startDate: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(),
            serviceRepeat: .everyWeek,
            serviceStatus: .finalized,
            isEvaluationCompleted: true,
            isFulfilled: true,
            serviceComment: "Sophie est excellente pédagogue ! Ma fille a progressé rapidement."
        ),
        ServiceClass(
            profileId: profiles[1],
            skill: .lending,
            serviceDescription: "Prêt de perceuse-visseuse sans fil et coffret de mèches. À récupérer chez moi.",
            city: "Paris",
            isFree: true,
            timeSpent: 0,
            startDate: Date(),
        ),
        ServiceClass(
            profileId: profiles[3],
            skill: .carSharing,
            serviceDescription: "Covoiturage Paris-Lyon ce week-end. 3 places disponibles. Départ samedi 8h.",
            city: "Paris",
            isFree: false,
            timeSpent: 4,
            startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date()
        ),
        ServiceClass(
            profileId: profiles[4],
            skill: .administrative,
            serviceDescription: "Aide aux démarches administratives : CAF, impôts, Sécurité sociale. Je vous accompagne dans vos papiers.",
            city: "Paris",
            isFree: false,
            timeSpent: 1,
            startDate: Calendar.current.date(byAdding: .day, value: 8, to: Date()) ?? Date()
        ),
        ServiceClass(
            profileId: profiles[6],
            skill: .pets,
            serviceDescription: "Garde de chat à mon domicile pendant vos vacances. J'ai l'habitude des félins !",
            city: "Paris",
            isFree: false,
            timeSpent: 24,
            startDate: Calendar.current.date(byAdding: .day, value: 15, to: Date()) ?? Date()
        )
    ]
    
    //  TIMEBANK
    let timeBanks: [TimeBankClass] = [
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 12, minute: 25).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .deepBlue,
            deposit: 1,
            withdrawal: 0,
            title: "Bienvenue sur Solid’Aide !",
            subtitle: "Solde de temps de bienvenue : +3h"
        ),
        TimeBankClass(
            userId:users[1],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .mintGreen,
            deposit: 0,
            withdrawal: 1,
            title: "Demande d’aide à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h"
        ),
        TimeBankClass(
            userId:users[2],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .warmCoral,
            deposit: 1,
            withdrawal: 0,
            title: "ProprofilePosition d’aide à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +3h"
        )
    ]

    //  LOOPS INSERT DETABASE
    for user in users { context.insert(user) }
    for profile in profiles { context.insert(profile) }
    for service in services { context.insert(service) }
    for timeBank in timeBanks { context.insert(timeBank) }
    for chat in chats { context.insert(chat) }
}
