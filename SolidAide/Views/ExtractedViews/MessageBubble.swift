//
//  MessageBubble.swift
//  SolidAide
//
//  Created by apprenant76 on 03/11/2025.
//

import SwiftUI
import SwiftData

struct MessageBubble: View {
    let message: ChatClass
    let isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            
            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                Text(message.message)
                    .padding(12)
                    .foregroundColor(isCurrentUser ? .white : .primary)
                    .background(
                        isCurrentUser ? Color.mintGreen :           Color(.mintGreen.opacity(0.2)),
                        in: UnevenRoundedRectangle(
                            topLeadingRadius: 16, bottomLeadingRadius: isCurrentUser ? 16 : 0, bottomTrailingRadius: isCurrentUser ? 0 : 16,
                            topTrailingRadius: 16
                        )
                    )
                
                Text(message.dateTime, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: 250, alignment: isCurrentUser ? .trailing : .leading)
            
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}
#Preview {
    ScrollView {
        VStack(spacing: 16) {
            MessageBubble(
                message: ChatClass(
                    dateTime: Date(),
                    sender: UserClass(logIn: "marie@email.fr", password: "123", balance: 5),
                    recipient: UserClass(logIn: "pierre@email.fr", password: "123", balance: 5),
                    message: "Bonjour ! Vous êtes disponible ?"
                ),
                isCurrentUser: false
            )
            
            MessageBubble(
                message: ChatClass(
                    dateTime: Date(),
                    sender: UserClass(logIn: "pierre@email.fr", password: "123", balance: 5),
                    recipient: UserClass(logIn: "marie@email.fr", password: "123", balance: 5),
                    message: "Oui, à 14h ça marche !"
                ),
                isCurrentUser: true
            )
        }
        .padding()
    }
}
