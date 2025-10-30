//
//  MessageClass.swift
//  SolidAide
//
//  Created by apprenant78 on 28/10/2025.
//

import Foundation
import SwiftData

@Model
class ChatClass: Identifiable {
    var id = UUID()
    var dateTime: Date
    var sender: UserClass
    var recipient: UserClass
    var message: String
    var isRead: Bool = false
    
    init(
        dateTime: Date,
        sender: UserClass,
        recipient: UserClass,
        message: String
    ) {
        self.dateTime = dateTime
        self.sender = sender
        self.recipient = recipient
        self.message = message
    }
}
