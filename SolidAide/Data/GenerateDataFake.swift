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
            logIn: "marie@email.fr",
            password: "password123",
            balance: 1
                 ),
        UserClass(  // 1
            logIn: "pierre@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass(  // 2
            logIn: "sophie@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass(  // 3
            logIn: "lucas@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass(  // 4
            logIn: "emma@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass(  // 5
            logIn: "thomas@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass(  // 6
            logIn: "julie@email.fr",
            password: "password123",
            balance: 5
                 ),
        UserClass( // 7
            logIn: "antoine@email.fr",
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
            pseudo: "Marie",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -35, to: Date()) ?? Date(),
            quality: [.reliableNeighbour, .punctual, .goodCommunication],
            imageURL: "image9",
            aboutMe: "Professeure de français, j'adore aider mes voisins et partager mes compétences en cuisine. Disponible en soirée et le week-end.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.896347, longitude: 2.345625),
            skills: [.cooking, .homeworkSupport, .administrative],
            availability: "Lundi-Vendredi: 18h-21h, Week-end: 9h-18h",
            contacts: [users[1], users[2], users[3], users[4], users[6]],
            favorite: [users[2], users[4]],
            helper: [users[1], users[3]],
            beneficiary: [users[2], users[4], users[6]]
        ),
        ProfileClass(
            userId: users[1],
            pseudo: "Pierre",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -42, to: Date()) ?? Date(),
            quality: [.efficient, .reliableNeighbour, .activeMember],
            imageURL: "image10",
            aboutMe: "Bricoleur passionné et retraité. Je propose mes services de bricolage et petits travaux. Très flexible sur les horaires.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.892304, longitude: 2.331346),
            skills: [.DIY, .moving, .lending],
            availability: "Tous les jours: 8h-20h",
            contacts: [users[0], users[2], users[3], users[5], users[7]],
            favorite: [users[3], users[5], users[7]],
            helper: [users[0], users[2]],
            beneficiary: [users[3], users[5]]
        ),
        ProfileClass(
            userId: users[2],
            pseudo: "Sophie",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -28, to: Date()) ?? Date(),
            quality: [.patient, .verySupportive, .goodCommunication],
            imageURL: "image11",
            aboutMe: "Étudiante en informatique, je peux aider avec les problèmes numériques et donner des cours de soutien scolaire en mathématiques.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.884286, longitude: 2.349548),
            skills: [.digital, .homeworkSupport, .trainingCourses],
            availability: "Mardi-Jeudi: 14h-19h, Samedi: 10h-16h",
            contacts: [users[0], users[1], users[3], users[4], users[7]],
            favorite: [users[0], users[7]],
            helper: [users[3], users[4]],
            beneficiary: [users[0], users[1], users[7]]
        ),
        ProfileClass(
            userId: users[3],
            pseudo: "Lucas",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -31, to: Date()) ?? Date(),
            quality: [.punctual, .available, .activeMember],
            imageURL: "image12",
            aboutMe: "Propriétaire d'un chien adorable, je promène volontiers les animaux du quartier. Je peux aussi faire du covoiturage.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.898136, longitude: 2.346827),
            skills: [.dogWalk, .carSharing, .pets],
            availability: "Matin: 7h-9h, Soir: 18h-20h",
            contacts: [users[0], users[1], users[2], users[4], users[6]],
            favorite: [users[1], users[4]],
            helper: [users[2], users[6]],
            beneficiary: [users[0], users[1], users[4]]
        ),
        ProfileClass(
            userId: users[4],
            pseudo: "Emma",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -39, to: Date()) ?? Date(),
            quality: [.goodCommunication, .patient, .verySupportive],
            imageURL: "image13",
            aboutMe: "Maman de trois enfants, j'adore cuisiner et faire les courses. Je peux aider avec les tâches administratives également.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.885704, longitude: 2.359410),
            skills: [.shopping, .cooking, .administrative, .householdTasks],
            availability: "Lundi-Vendredi: 9h-15h",
            contacts: [users[0], users[2], users[3], users[5], users[7]],
            favorite: [users[3], users[5]],
            helper: [users[0], users[2], users[7]],
            beneficiary: [users[3], users[5]]
        ),
        ProfileClass(
            userId: users[5],
            pseudo: "Thomas",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -45, to: Date()) ?? Date(),
            quality: [.reliableNeighbour, .efficient, .punctual],
            imageURL: "image6",
            aboutMe: "Expert en déménagement et transport. J'ai un camion et je peux aider pour les gros travaux de déménagement.",
            profilePosition: CLLocationCoordinate2D(latitude: 48.895232, longitude: 2.351775),
            skills: [.moving, .carSharing, .DIY],
            availability: "Week-end: 8h-19h",
            contacts: [users[1], users[4], users[6], users[7]],
            favorite: [users[1], users[7]],
            helper: [users[4], users[6]],
            beneficiary: [users[1], users[7]]
        ),
        ProfileClass(
            userId: users[6],
            pseudo: "Julie",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -26, to: Date()) ?? Date(),
            quality: [.patient, .goodCommunication, .available],
            imageURL: "image7",
            aboutMe: "Couturière professionnelle, je propose des retouches et créations sur mesure. Passionnée par mon métier !",
            profilePosition: CLLocationCoordinate2D(latitude: 48.885332, longitude: 2.334209),
            skills: [.sewing, .householdTasks],
            availability: "Mercredi-Samedi: 10h-18h",
            contacts: [users[0], users[3], users[5]],
            favorite: [users[3]],
            helper: [users[0]],
            beneficiary: [users[3], users[5]]
        ),
        ProfileClass(
            userId: users[7],
            pseudo: "Antoine",
            city: "Paris",
            birthday: Calendar.current.date(byAdding: .year, value: -52, to: Date()) ?? Date(),
            quality: [.activeMember, .verySupportive, .reliableNeighbour, .efficient],
            imageURL: "image8",
            aboutMe: "Formateur en bureautique et gestion. Je donne des formations gratuites aux seniors et débutants. Membre actif depuis 2 ans !",
            profilePosition: CLLocationCoordinate2D(latitude: 48.891212, longitude: 2.348629),
            skills: [.trainingCourses, .digital, .administrative],
            availability: "Lundi-Mercredi-Vendredi: 14h-17h",
            contacts: [users[1], users[2], users[4], users[5], users[8]],
            favorite: [users[2], users[4], users[8]],
            helper: [users[1], users[5]],
            beneficiary: [users[2], users[4], users[8]]
        ),
        ProfileClass(
            userId: users[8],
            pseudo: "Andrei",
            city: "Nice",
            birthday: Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date(),
            quality: [.activeMember, .efficient, .punctual],
            imageURL: "image2",
            aboutMe: "Développeur Swift 🧑🏼‍💻 & passionné de bricolage !",
            profilePosition: CLLocationCoordinate2D(latitude: 48.887450, longitude: 2.335820),
            skills: [.DIY, .digital, .trainingCourses, .moving],
            availability: "Lundi-Vendredi: 9h-18h",
            contacts: [users[7], users[9], users[10], users[11], users[12]],
            favorite: [users[9], users[10], users[12]],
            helper: [users[7], users[11]],
            beneficiary: [users[9], users[10], users[12]]
        ),
        ProfileClass(
            userId: users[9],
            pseudo: "Stacy",
            city: "Toulouse",
            birthday: Calendar.current.date(byAdding: .year, value: -28, to: Date()) ?? Date(),
            quality: [.patient, .verySupportive, .goodCommunication],
            imageURL: "image3",
            aboutMe: "Développeuse app mobile, passionée de design et forgeronne demi-professionelle 🏳️‍⚧️🦄!",
            profilePosition: CLLocationCoordinate2D(latitude: 48.893560, longitude: 2.355140),
            skills: [.DIY, .digital, .sewing, .lending],
            availability: "Mardi-Jeudi: 10h-17h",
            contacts: [users[8], users[10], users[11], users[12]],
            favorite: [users[8], users[11]],
            helper: [users[10], users[12]],
            beneficiary: [users[8], users[11]]
        ),
        ProfileClass(
            userId: users[10],
            pseudo: "Séverine",
            city: "Marseille",
            birthday: Calendar.current.date(byAdding: .year, value: -33, to: Date()) ?? Date(),
            quality: [.reliableNeighbour, .activeMember, .goodCommunication],
            imageURL: "image5",
            aboutMe: "Développeuse Swift et j'adore cuisiner, aider c'est une des mes passions 👩🏻‍💻🥙!",
            profilePosition: CLLocationCoordinate2D(latitude: 48.889320, longitude: 2.341500),
            skills: [.digital, .cooking, .homeworkSupport, .administrative],
            availability: "Lundi-Vendredi: 14h-19h",
            contacts: [users[8], users[9], users[11], users[12]],
            favorite: [users[9], users[12]],
            helper: [users[8], users[11]],
            beneficiary: [users[9], users[12]]
        ),
        ProfileClass(
            userId: users[11],
            pseudo: "Edilene",
            city: "Lille",
            birthday: Calendar.current.date(byAdding: .year, value: -29, to: Date()) ?? Date(),
            quality: [.patient, .punctual, .verySupportive],
            imageURL: "image1",
            aboutMe: "Développeuse app mobile, j'adore la mathematique et danser de la musique brésilienne 💃🏻",
            profilePosition: CLLocationCoordinate2D(latitude: 48.894780, longitude: 2.350920),
            skills: [.digital, .homeworkSupport, .trainingCourses, .cooking],
            availability: "Mercredi-Samedi: 9h-16h",
            contacts: [users[8], users[9], users[10], users[12]],
            favorite: [users[10], users[12]],
            helper: [users[8], users[9]],
            beneficiary: [users[10], users[12]]
        ),
        ProfileClass(
            userId: users[12],
            pseudo: "Florian",
            city: "Aniche",
            birthday: Calendar.current.date(byAdding: .year, value: -31, to: Date()) ?? Date(),
            quality: [.activeMember, .efficient, .reliableNeighbour],
            imageURL: "image4",
            aboutMe: "Développeur Swift, solidarité et musique sont mes passions préférées 🩷",
            profilePosition: CLLocationCoordinate2D(latitude: 48.890100, longitude: 2.337450),
            skills: [.digital, .DIY, .trainingCourses, .carSharing],
            availability: "Tous les jours: 10h-20h",
            contacts: [users[8], users[9], users[10], users[11]],
            favorite: [users[8], users[10], users[11]],
            helper: [users[9], users[11]],
            beneficiary: [users[8], users[10]]
        )
    ]
    
    //  CHATS
    let chats: [ChatClass] = [
        // Marie & Pierre
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -48, to: Date()) ?? Date(), sender: users[0], recipient: users[1], message: "Bonjour Pierre ! Seriez-vous disponible demain pour réparer ma table ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -47, to: Date()) ?? Date(), sender: users[1], recipient: users[0], message: "Bonjour Marie ! Oui bien sûr, je peux passer vers 14h. Ça vous convient ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -46, to: Date()) ?? Date(), sender: users[0], recipient: users[1], message: "Parfait ! À demain alors 😊", isRead: true),
        
        // Marie & Sophie
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -24, to: Date()) ?? Date(), sender: users[0], recipient: users[2], message: "Coucou Sophie ! Tu aurais du temps pour m'aider avec mon ordinateur ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -23, to: Date()) ?? Date(), sender: users[2], recipient: users[0], message: "Salut Marie ! Oui, je peux passer ce soir si tu veux !", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -30, to: Date()) ?? Date(), sender: users[0], recipient: users[2], message: "Super ! Vers 19h ?", isRead: false),
        
        // Marie & Lucas
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -12, to: Date()) ?? Date(), sender: users[0], recipient: users[3], message: "Bonjour Lucas, aurais-tu des disponibilités pour garder mon chat la semaine prochaine ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -11, to: Date()) ?? Date(), sender: users[3], recipient: users[0], message: "Salut Marie ! Oui sans problème, je peux le faire 🐱", isRead: true),
        
        // Marie & Emma
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), sender: users[4], recipient: users[0], message: "Marie, j'ai fait tes courses ! Tu es chez toi ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), sender: users[0], recipient: users[4], message: "Oh merci Emma ! Oui j'arrive dans 5 minutes !", isRead: true),
        
        // Marie & Julie
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -6, to: Date()) ?? Date(), sender: users[0], recipient: users[6], message: "Julie, tu aurais le temps de faire un ourlet cette semaine ?", isRead: false),
        
        // Pierre & Sophie
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), sender: users[1], recipient: users[2], message: "Sophie, mon ordi fait des bruits bizarres... Tu peux regarder ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), sender: users[2], recipient: users[1], message: "Pas de souci Pierre ! Je passe demain matin ?", isRead: true),
        
        // Pierre & Lucas
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -72, to: Date()) ?? Date(), sender: users[3], recipient: users[1], message: "Pierre, j'ai besoin d'aide pour monter une étagère IKEA 😅", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -71, to: Date()) ?? Date(), sender: users[1], recipient: users[3], message: "Haha ! Je viens avec ma boîte à outils 🔧", isRead: true),
        
        // Pierre & Thomas
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -15, to: Date()) ?? Date(), sender: users[1], recipient: users[5], message: "Thomas, tu pourrais m'aider à transporter un meuble ce weekend ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -14, to: Date()) ?? Date(), sender: users[5], recipient: users[1], message: "Avec plaisir ! Samedi matin ça te va ?", isRead: true),
        
        // Pierre & Antoine
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), sender: users[7], recipient: users[1], message: "Pierre, tu voudrais apprendre à utiliser Excel ? Je fais une formation gratuite.", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), sender: users[1], recipient: users[7], message: "Oh oui ! Ça m'intéresse beaucoup !", isRead: true),
        
        // Sophie & Lucas
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -20, to: Date()) ?? Date(), sender: users[2], recipient: users[3], message: "Lucas, je cherche quelqu'un pour du covoiturage régulier. Tu fais Paris-Toulouse ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -19, to: Date()) ?? Date(), sender: users[3], recipient: users[2], message: "Pas régulièrement, mais je préviens quand j'y vais !", isRead: true),
        
        // Sophie & Emma
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -90, to: Date()) ?? Date(), sender: users[4], recipient: users[2], message: "Sophie, tu donnes toujours des cours de maths ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -85, to: Date()) ?? Date(), sender: users[2], recipient: users[4], message: "Oui ! Pour tes enfants ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -80, to: Date()) ?? Date(), sender: users[4], recipient: users[2], message: "Exactement ! Ma fille galère en algèbre 😅", isRead: false),
        
        // Sophie & Antoine
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -36, to: Date()) ?? Date(), sender: users[2], recipient: users[7], message: "Bonjour Antoine, je suis intéressée par votre formation Excel !", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -35, to: Date()) ?? Date(), sender: users[7], recipient: users[2], message: "Avec plaisir Sophie ! On commence quand vous voulez. Vous avez déjà des bases ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -34, to: Date()) ?? Date(), sender: users[2], recipient: users[7], message: "Quelques notions seulement. Mercredi après-midi ce serait possible ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -33, to: Date()) ?? Date(), sender: users[7], recipient: users[2], message: "Mercredi 14h c'est parfait ! Je vous envoie mon adresse.", isRead: true),
        
        // Lucas & Emma
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -8, to: Date()) ?? Date(), sender: users[3], recipient: users[4], message: "Salut Emma ! Tu pourrais me faire des courses cette semaine ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -7, to: Date()) ?? Date(), sender: users[4], recipient: users[3], message: "Salut Lucas ! Oui pas de souci, tu me fais une liste ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -15, to: Date()) ?? Date(), sender: users[3], recipient: users[4], message: "Je t'envoie ça par SMS ! Merci beaucoup 🙏", isRead: false),
        
        // Lucas & Julie
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), sender: users[6], recipient: users[3], message: "Lucas, ton chien est adorable ! Tu le promènes tous les matins ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date(), sender: users[3], recipient: users[6], message: "Oui ! Si tu veux je peux promener le tien aussi 🐕", isRead: true),
        
        // Emma & Thomas
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -50, to: Date()) ?? Date(), sender: users[5], recipient: users[4], message: "Emma, j'ai besoin d'aide pour déménager la semaine prochaine", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -49, to: Date()) ?? Date(), sender: users[4], recipient: users[5], message: "Compte sur moi Thomas ! Quel jour ?", isRead: true),
        
        // Emma & Antoine
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -120, to: Date()) ?? Date(), sender: users[4], recipient: users[7], message: "Antoine, tu peux m'aider avec ma déclaration d'impôts ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -115, to: Date()) ?? Date(), sender: users[7], recipient: users[4], message: "Bien sûr Emma ! Apporte tes documents vendredi", isRead: true),
        
        // Thomas & Julie
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -60, to: Date()) ?? Date(), sender: users[5], recipient: users[6], message: "Bonjour Julie, auriez-vous un créneau cette semaine pour un ourlet de pantalon ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -55, to: Date()) ?? Date(), sender: users[6], recipient: users[5], message: "Bonjour Thomas ! Oui, vendredi matin. Apportez le pantalon, je le fais sur place 🪡", isRead: true),
        
        // Thomas & Antoine
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), sender: users[7], recipient: users[5], message: "Thomas, tu as ton camion disponible samedi ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), sender: users[5], recipient: users[7], message: "Oui Antoine ! Tu déménages ?", isRead: true),
        
        // Antoine & Andrei
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -4, to: Date()) ?? Date(), sender: users[8], recipient: users[7], message: "Salut Antoine ! Tu donnes toujours des cours d'informatique ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -3, to: Date()) ?? Date(), sender: users[7], recipient: users[8], message: "Salut Andrei ! Oui toujours ! Tu as besoin d'aide ?", isRead: false),
        
        // Andrei & Stacy
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), sender: users[8], recipient: users[9], message: "Hey Stacy ! Ton projet de forge avance ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), sender: users[9], recipient: users[8], message: "Oui ! Je viens de finir une épée 🗡️ Tu veux voir ?", isRead: true),
        
        // Andrei & Séverine
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -10, to: Date()) ?? Date(), sender: users[10], recipient: users[8], message: "Andrei, tu peux m'aider à débugger mon app ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -9, to: Date()) ?? Date(), sender: users[8], recipient: users[10], message: "Bien sûr Séverine ! Envoie-moi le code 👨🏼‍💻", isRead: true),
        
        // Andrei & Edilene
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -200, to: Date()) ?? Date(), sender: users[8], recipient: users[11], message: "Edilene, tu veux coder ensemble ce weekend ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -195, to: Date()) ?? Date(), sender: users[11], recipient: users[8], message: "Avec plaisir ! On fait un hackathon ? 💻", isRead: true),
        
        // Andrei & Florian
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date()) ?? Date(), sender: users[12], recipient: users[8], message: "Andrei, j'ai besoin d'aide pour réparer ma table", isRead: false),
        
        // Stacy & Séverine
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), sender: users[9], recipient: users[10], message: "Séverine ! Ta recette de bouillabaisse était délicieuse 😋", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), sender: users[10], recipient: users[9], message: "Merci Stacy ! Je t'envoie la recette 🥘", isRead: true),
        
        // Stacy & Edilene
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -18, to: Date()) ?? Date(), sender: users[11], recipient: users[9], message: "Stacy, tu viens danser ce weekend ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -17, to: Date()) ?? Date(), sender: users[9], recipient: users[11], message: "Oui ! Forró ou samba ? 💃", isRead: true),
        
        // Stacy & Florian
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -45, to: Date()) ?? Date(), sender: users[12], recipient: users[9], message: "Stacy, tu peux me prêter tes outils de forge ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -40, to: Date()) ?? Date(), sender: users[9], recipient: users[12], message: "Pas de souci Florian ! Passe les chercher quand tu veux", isRead: true),
        
        // Séverine & Edilene
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(), sender: users[10], recipient: users[11], message: "Edilene, on révise ensemble pour le cours de maths ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .hour, value: -4, to: Date()) ?? Date(), sender: users[11], recipient: users[10], message: "Oui ! J'adore les maths ! Demain soir ?", isRead: true),
        
        // Séverine & Florian
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), sender: users[12], recipient: users[10], message: "Séverine, tu veux faire du covoiturage pour aller au meetup ?", isRead: true),
        ChatClass(dateTime: Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date(), sender: users[10], recipient: users[12], message: "Super idée ! On se retrouve où ?", isRead: true),
        
        // Edilene & Florian
        ChatClass(dateTime: Calendar.current.date(byAdding: .minute, value: -10, to: Date()) ?? Date(), sender: users[11], recipient: users[12], message: "Florian, merci pour le coup de main avec mon code ! 🙏", isRead: false),
    ]
    
    //  SERVICES
    let services = [
        // Marie demande
        ServiceClass(profileId: profiles[0], skill: .DIY, serviceDescription: "Besoin d'aide pour réparer ma bibliothèque qui penche dangereusement", city: "Paris", isFree: false, timeSpent: 2, startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date()),
        
        // Pierre demande
        ServiceClass(profileId: profiles[1], profileIdHelper: profiles[2], skill: .digital, serviceDescription: "J'ai besoin d'aide pour installer et configurer Windows 11 sur mon PC", city: "Paris", isFree: false, timeSpent: 2, startDate: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), serviceStatus: .finalized, isEvaluationCompleted: true, isFulfilled: true, serviceComment: "Sophie a été très patiente et pédagogue !"),
        
        // Sophie demande
        ServiceClass(profileId: profiles[2], skill: .moving, serviceDescription: "Besoin d'aide pour déménager quelques cartons vers mon nouveau studio", city: "Paris", isFree: false, timeSpent: 3, startDate: Calendar.current.date(byAdding: .day, value: 10, to: Date()) ?? Date()),
        
        // Lucas demande
        ServiceClass(profileId: profiles[3], profileIdHelper: profiles[0], skill: .cooking, serviceDescription: "J'aimerais apprendre à cuisiner des plats français traditionnels", city: "Paris", isFree: false, timeSpent: 2, startDate: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(), serviceRepeat: .everyWeek, serviceStatus: .awaitingAcceptance),
        
        // Emma demande
        ServiceClass(profileId: profiles[4], profileIdHelper: profiles[2], skill: .homeworkSupport, serviceDescription: "Soutien scolaire en mathématiques pour ma fille en 3ème", city: "Paris", isFree: false, timeSpent: 2, startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(), serviceRepeat: .everyWeek, serviceStatus: .approved),
        
        // Thomas demande
        ServiceClass(profileId: profiles[5], profileIdHelper: profiles[6], skill: .sewing, serviceDescription: "Retouches de 3 pantalons (ourlets) pour mon nouveau travail", city: "Paris", isFree: false, timeSpent: 1, startDate: Calendar.current.date(byAdding: .day, value: 2, to: Date()) ?? Date(), serviceStatus: .awaitingEvaluation, isFulfilled: true),
        
        // Julie demande
        ServiceClass(profileId: profiles[6], profileIdHelper: profiles[3], skill: .pets, serviceDescription: "Garde de mon chat pendant mes vacances (1 semaine)", city: "Paris", isFree: false, timeSpent: 7, startDate: Calendar.current.date(byAdding: .day, value: 20, to: Date()) ?? Date(), serviceStatus: .approved),
        
        // Antoine demande
        
        ServiceClass(profileId: profiles[7], skill: .cooking, serviceDescription: "Cours de pâtisserie française : apprendre à faire des éclairs", city: "Paris", isFree: false, timeSpent: 3, startDate: Calendar.current.date(byAdding: .day, value: 12, to: Date()) ?? Date()),
        
        // Andrei demande
        ServiceClass(profileId: profiles[8], profileIdHelper: profiles[11], skill: .householdTasks, serviceDescription: "Grand ménage de printemps de mon appartement", city: "Nice", isFree: false, timeSpent: 2, startDate: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(), serviceRepeat: .everyWeek, serviceStatus: .approved),
        
        // Stacy demande
        
        ServiceClass(profileId: profiles[9], skill: .administrative, serviceDescription: "Aide pour créer mon auto-entreprise (démarches administratives)", city: "Toulouse", isFree: false, timeSpent: 3, startDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()),
        
        // Séverine demande
        ServiceClass(profileId: profiles[10], profileIdHelper: profiles[11], skill: .trainingCourses, serviceDescription: "Perfectionnement en Python : apprendre les design patterns", city: "Marseille", isFree: false, timeSpent: 4, startDate: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(), serviceRepeat: .everyWeek, serviceStatus: .approved),
        
        // Edilene demande
        
        ServiceClass(profileId: profiles[11], skill: .shopping, serviceDescription:"Courses alimentaires hebdomadaires (liste fournie)", city: "Lille", isFree: false, timeSpent: 3, startDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(), serviceRepeat: .everyWeek),
        
        // Florian demande
        
        ServiceClass(profileId: profiles[12], skill: .lending, serviceDescription: "Prêt d'une perceuse pour accrocher des tableaux", city: "Aniche", isFree: true, timeSpent: 0, startDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date())
    ]
    
    //  TIMEBANK
    //    let timeBanks: [TimeBankClass] = [
    //        TimeBankClass(
    //
    //            userId:users[0],
    //            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 12, minute: 25).date!,
    //            iconName: "hourglass.badge.plus",
    //            iconColor: .deepBlue,
    //            deposit: 1,
    //            withdrawal: 0,
    //            title: "Bienvenue sur Solid'Aide !",
    //            subtitle: "Solde de temps de bienvenue : +3h"
    //        ),
    //        TimeBankClass(
    //            userId:users[1],
    //            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 16, minute: 0).date!,
    //            iconName: "hourglass.tophalf.filled",
    //            iconColor: .mintGreen,
    //            deposit: 0,
    //            withdrawal: 1,
    //            title: "Demande d'aide à Angela pour passer la tondeuse.",
    //            subtitle: "Solde de temps dépensé : -1h"
    //        ),
    //        TimeBankClass(
    //            userId:users[2],
    //            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
    //            iconName: "hourglass.badge.plus",
    //            iconColor: .warmCoral,
    //            deposit: 1,
    //            withdrawal: 0,
    //            title: "Proposition d'aide à Ghania pour bricoler.",
    //            subtitle: "Solde de temps gagné : +3h"
    //        )
    //    ]
    let timeBanks: [TimeBankClass] = [
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 03, hour: 12, minute: 25).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .deepBlue,
            deposit: 3,
            withdrawal: 0,
            title: "Bienvenue sur Solid’Aide !",
            subtitle: "Solde de temps de bienvenue : +3h"
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 04, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour du passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 05, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .mintGreen,
            deposit: 3,
            withdrawal: 0,
            title: "Proposition de service à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +3h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 06, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .mintGreen,
            deposit: 2,
            withdrawal: 0,
            title: "Proposition de service à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +2h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 07, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 08, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 09, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 10, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 11, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .mintGreen,
            deposit: 2,
            withdrawal: 0,
            title: "Proposition de service à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +2h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 12, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .mintGreen,
            deposit: 2,
            withdrawal: 0,
            title: "Proposition de service à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +2h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 13, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 14, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 15, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 16, hour: 16, minute: 0).date!,
            iconName: "hourglass.tophalf.filled",
            iconColor: .warmCoral,
            deposit: 0,
            withdrawal: 1,
            title: "Demande de service à Angela pour passer la tondeuse.",
            subtitle: "Solde de temps dépensé : -1h",
            
        ),
        TimeBankClass(
            userId:users[0],
            date: DateComponents(calendar: .current, year: 2025, month: 10, day: 17, hour: 9, minute: 0).date!,
            iconName: "hourglass.badge.plus",
            iconColor: .mintGreen,
            deposit: 2,
            withdrawal: 0,
            title: "Proposition de service à Ghania pour bricoler.",
            subtitle: "Solde de temps gagné : +2h",
        )
    ]
    //  LOOPS INSERT DETABASE
    for user in users { context.insert(user) }
    for profile in profiles { context.insert(profile) }
    for service in services { context.insert(service) }
    for timeBank in timeBanks { context.insert(timeBank) }
    for chat in chats { context.insert(chat) }
}
