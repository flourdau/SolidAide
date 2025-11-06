import SwiftUI

struct DetailHistoricalServiceView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Détail du service historique")
                .font(.title2)
                .foregroundStyle(.primary)

            // Exemple de champs – à adapter avec votre modèle réel
            Text("Compétence : DIY")
            Text("Description : Besoin d’aide pour réparer une étagère")
            Text("Ville : Paris")
            Text("Date : 12 oct. 2025")
        }
        .padding()
    }
}

#Preview {
    DetailHistoricalServiceView()
}
