//
//  ConversationView.swift
//  SolidAide
//
//  Created by apprenant76 on 31/10/2025.
//

import SwiftUI
import SwiftData

struct ConversationView: View {
    @Environment(\.modelContext) private var modelContext
    
    let contactInfo: ProfileClass
    let messages: ChatClass
    
    var body: some View {
        HStack {
            VStack{
                HStack{
                    ZStack {
                        Circle()
                            .frame(width: 70, height: 70)
                            .foregroundStyle(.deepBlue)
                        Image(contactInfo.imageURL ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    VStack{
                        Text(contactInfo.pseudo)
                            .font(.title2)
                            .bold()
                        Text("En ligne")
                    }
                }
                
                Text(messages.message)
                    .background(Color(.mintGreen))
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: UserClass.self, ProfileClass.self, ChatClass.self, ServiceClass.self, TimeBankClass.self,
        configurations: config
    )
    let context = ModelContext(container)
    
    GenerateDataBaseFunc(context: context)
    
    let descriptor = FetchDescriptor<ProfileClass>()
    let profiles = try! context.fetch(descriptor)
    
    let chatDescriptor = FetchDescriptor<ChatClass>()
       let chats = try! context.fetch(chatDescriptor)
       
       return ConversationView(
           contactInfo: profiles[0],
           messages: chats[0])        .modelContainer(container)
}
