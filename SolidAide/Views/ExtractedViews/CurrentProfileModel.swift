//
//  CurrentProfileModel.swift
//  SolidAide
//
//  Created by Andrei Anisimov on 03/11/2025.
//

import SwiftUI
import SwiftData
import Observation

@Observable
class CurrentProfileModel {
    var profile: ProfileClass?

    init(context: ModelContext) {
        let descriptor = FetchDescriptor<ProfileClass>()
        if let existing = try? context.fetch(descriptor).first {
            self.profile = existing
        } else {
            let demo = ProfileClass(
                pseudo: "melanie_blanc",
                city: "Paris",
                birthday: Date(timeIntervalSince1970: 946684800),
                aboutMe: "Passionnée de jardinage, j’aime aider et rencontrer de nouvelles personnes."
            )
            context.insert(demo)
            try? context.save()
            self.profile = demo
        }
    }
}

struct CurrentProfileModelPreviewView: View {
    @Environment(\.modelContext) private var context
    @State private var model: CurrentProfileModel

    init() {
        // on crée un container in-memory pour le preview
        let container = try! ModelContainer(for: ProfileClass.self, configurations: .init(isStoredInMemoryOnly: true))
        let ctx = container.mainContext
        _model = State(initialValue: CurrentProfileModel(context: ctx))
    }

    var body: some View {
        VStack(spacing: 12) {
            Text("Profil courant :")
                .font(.headline)
            Text(model.profile?.pseudo ?? "—")
            Text(model.profile?.city ?? "—")
            Text(model.profile?.aboutMe ?? "—")
        }
        .padding()
    }
}

#Preview {
    CurrentProfileModelPreviewView()
}
