import SwiftUI
import SwiftData
import Observation

struct ServiceDetailView: View {
    @Bindable var service: ServiceClass
    @Bindable var user: UserClass

    @State private var showingEditSheet = false
    @State private var showingAcceptService = false

    var body: some View {
        Form {
            Section("Détails du Service") {
                LabeledContent("Compétence", value: service.skill.rawValue)
                LabeledContent("Description", value: service.serviceDescription)
                LabeledContent("Ville", value: service.city)
                LabeledContent("Date", value: service.startDate.formatted(date: .abbreviated, time: .shortened))
            }

            Section("Personnes") {
                Text("Demandeur : \(service.profileId.pseudo)")
                Text("Helper : \(service.profileIdHelper?.pseudo ?? "Non assigné")")
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

            if service.profileId.userId?.id != user.id {
                ButtonAcceptServiceView(showingAddService: $showingAcceptService)
            }
        }
        .navigationTitle("Détail du Service")
        .toolbar {
            ToolbarItem {
                if service.profileId.userId?.id != user.id {
                    Button("Modifier") {
                        showingEditSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            ServiceEditView(viewModel: ServiceFormViewModel(service: service))
        }
    }
}
