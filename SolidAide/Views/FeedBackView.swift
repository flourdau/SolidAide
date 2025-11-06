/*
 __
 / ()  ,_   _  _, _|_  _  _|     |)           ()_|_  _,   _
 |     /  | |/ / |  |  |/ / |     |/\_|  |     /\ |  / |  /   |  |
 \___/   |/|_/\/|_/|_/|_/\/|_/    \/  \/|/   /(_)|_/\/|_/\__/ \/|/
 (|                      (|
 */
import SwiftUI

struct FeedBackView: View {
    /*
     ______            _ ____             _
     |  ____|          | |  _ \           | |
     | |__ ___  ___  __| | |_) | __ _  ___| | __
     |  __/ _ \/ _ \/ _` |  _ < / _` |/ __| |/ /
     | | |  __/  __/ (_| | |_) | (_| | (__|   <
     |_|  \___|\___|\__,_|____/ \__,_|\___|_|\_\
     
     */
    @State private var commentSelection: Bool = true
    @State private var comment: String = ""
    @State private var hasEditedComment = false
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputFocused: Bool
    
    /*
     _____                    __
     / ____|                  / _|                   _
     | (___   __ ___   _____  | |_ _   _ _ __   ___  (_)
     \___ \ / _` \ \ / / _ \ |  _| | | | '_ \ / __|
     ____) | (_| |\ V /  __/ | | | |_| | | | | (__   _
     |_____/ \__,_| \_/ \___| |_|  \__,_|_| |_|\___| (_)
     */
    private func saveFeedback() {
        print("=== Feedback enregistré ===")
        print("Service rendu correctement ? :", commentSelection ? "Oui" : "Non")
        if !commentSelection {
            print("Commentaire :", comment)
        }
        print("===========================")
    }
    /*
     ____            _    __      ___
     |  _ \          | |   \ \    / (_)
     | |_) | ___   __| |_   \ \  / / _  _____      __
     |  _ < / _ \ / _` | | | \ \/ / | |/ _ \ \ /\ / /
     | |_) | (_) | (_| | |_| |\  /  | |  __/\ V  V /
     |____/ \___/ \__,_|\__, | \/   |_|\___| \_/\_/
     __/ |
     |___/
     */
    var body: some View {
        
        VStack {
            Text("Donnez-nous votre avis :")
                .font(.title)
                .foregroundStyle(Color(.green))
                .padding()
                .fontWeight(.bold)
            Text("Le service que vous avez reçu a-t-il été rendu comme convenu ?")
            
            ColoredSegmentedControl(selection: $commentSelection)
                .padding()
            if !commentSelection {
                Text("Si non, souhaitez‑vous ajouter un commentaire :")
                    .font(.subheadline)
                
                
                ZStack(alignment: .topLeading) {
                    if comment.isEmpty {
                        VStack {
                            Text("Saisissez votre note ou commentaire ici...") // Votre texte indicatif
                                .foregroundColor(.gray)
                                .padding(.top, 8)  // Ajustement pour correspondre au début du texte
                                .padding(.leading, 5) // Ajustement pour correspondre au début du texte
                            Spacer()
                        }
                    }
                    
                    TextEditor(text: $comment)
                        .opacity(comment.isEmpty ? 0.8 : 1) // Rendre le TextEditor légèrement transparent si le placeholder est visible pour améliorer l'effet
                }
                .frame(height: 200) // Définir une hauteur pour le TextEditor
                .border(Color.gray)
                .padding(.horizontal, 24)// (Optionnel) Ajout d'une bordure pour visualiser la zone de saisie
                
            }
            Spacer()
            /*
             ______            _ ____             _
             |  ____|          | |  _ \           | |
             | |__ ___  ___  __| | |_) | __ _  ___| | __
             |  __/ _ \/ _ \/ _` |  _ < / _` |/ __| |/ /
             | | |  __/  __/ (_| | |_) | (_| | (__|   <
             |_|  \___|\___|\__,_|____/ \__,_|\___|_|\_\
             ____        _   _
             |  _ \      | | | |
             | |_) |_   _| |_| |_ ___  _ __  ___
             |  _ <| | | | __| __/ _ \| '_ \/ __|
             | |_) | |_| | |_| || (_) | | | \__ \
             |____/ \__,_|\__|\__\___/|_| |_|___/
             
             */
            FeedBackButtonsView()
            /*
             _____                _         _____
             / ____|              | | ___   / ____|
             | (___   ___ _ __   __| |( _ ) | (___   __ ___   _____
             \___ \ / _ \ '_ \ / _` |/ _ \/\\___ \ / _` \ \ / / _ \
             ____) |  __/ | | | (_| | (_>  <____) | (_| |\ V /  __/
             |_____/ \___|_| |_|\__,_|\___/\/_____/ \__,_| \_/ \___|
             */
            Button(action: {
                saveFeedback()
                dismiss()
            }) {
                Text("Envoyer")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.mintGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding([.horizontal, .bottom], 16)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isInputFocused = true
            }
        }
    }
}

#Preview {
    FeedBackView()
}
