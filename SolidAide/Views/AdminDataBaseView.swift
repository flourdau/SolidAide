//
//  AdminDataBaseView.swift
//  SolidAide
//
//  Created by apprenant78 on 30/10/2025.
//

import SwiftUI
import SwiftData

struct AdminDataBaseView: View {
    @Environment(\.modelContext) private var context
    func ResetDataBaseFunc(context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<UserClass>()
            let usersToDelete = try context.fetch(fetchDescriptor)
            
            for user in usersToDelete {
                context.delete(user)
            }
            print("Base de données User réinitialisée avec succès.")
        }
        catch {
            print("Échec de la réinitialisation de la base de données : \(error)")
        }
    }
    
    @Query var users: [UserClass]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user.logIn)
                        .font(.headline)
                }
            }
            
            HStack {
                Button("Générer") {
                    GenerateDataBaseFunc(context: context)
                }
                .foregroundStyle(.white)
                .padding(24)
                .background(.pink)
                .cornerRadius(16)
                
                Button("Delete User") {
                    ResetDataBaseFunc(context: context)
                }
                .foregroundStyle(.white)
                .padding(24)
                .background(.pink)
                .cornerRadius(16)
                
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserClass.self, configurations: config)
        
        GenerateDataBaseFunc(context: container.mainContext)
        return AdminDataBaseView()
            .modelContainer(container)
        
    } catch {
       fatalError("Échec de la création du ModelContainer pour la preview : \(error)")
    }
}
