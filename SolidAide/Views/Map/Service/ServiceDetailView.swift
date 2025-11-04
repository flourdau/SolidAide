//
//  ServiceDetailView.swift
//  SolidAide
//
//  Created by apprenant78 on 02/11/2025.
//

// Fichier: ServiceDetailView.swift
import SwiftUI

struct ServiceDetailView: View {
    @Bindable var service: ServiceClass
    @State private var showingEditSheet = false

    var body: some View {
        Form {
            Section("Détails du Service") {
                LabeledContent("Compétence", value: service.skill.rawValue)
                LabeledContent("Description", value: service.serviceDescription)
                LabeledContent("Ville", value: service.city)
                LabeledContent("Date", value: service.startDate.formatted(date: .abbreviated, time: .shortened))
            }
            
            Section("Personnes") {
                Text("Demandeur: \(service.profileId.pseudo)")
                Text("Helper: \(service.profileIdHelper?.pseudo ?? "Non assigné")")
            }
            
            Section("Statut") {
                LabeledContent("Statut", value: service.serviceStatus.rawValue)
                LabeledContent("Gratuit", value: service.isFree ? "Oui" : "Non")
                LabeledContent("Terminé", value: service.isFulfilled ? "Oui" : "Non")
            }
            
            if let comment = service.serviceComment, !comment.isEmpty {
                Section("Commentaire") {
                    Text(comment)
                }
            }
        }
        .navigationTitle("Détail du Service")
        .toolbar {
            ToolbarItem {
                Button("Modifier") {
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            /// (U)PDATE:
            ServiceEditView(viewModel: ServiceFormViewModel(service: service))
        }
    }
}



#Preview {
//              ServiceDetailView(service: service)

}
