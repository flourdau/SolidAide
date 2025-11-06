//
//  ButtonAcceptServiceView.swift
//  SolidAide
//
//  Created by apprenant78 on 05/11/2025.
//

import SwiftUI

struct ButtonAcceptServiceView: View {
    @Binding var showingAddService: Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Button {
                showingAddService = true
                dismiss()
            } label: {
                HStack{
                    Image(systemName:"hand.wave")
                    VStack{
                        Text("Accepter")
                            .padding(.trailing, 12)
                    }
                }
                .padding(12)
                .background(.warmCoral)
                .foregroundStyle(.white)
                .cornerRadius(32)
                .font(.system(size: 18))
                .bold()
            }
            .padding(.bottom, 24)
            .alert(isPresented: $showingAddService) {
                Alert(
                    title: Text("Débiter 1h !"),
                    message: Text("Êtes-vous sûr de vouloir débiter 1h de la personne à qui vous avez rendu service?"),
                    primaryButton: .destructive(Text("Débiter")) {
                        dismiss()
                    },
                    secondaryButton: .cancel(
                        Text("Annuler")
//                                dismiss()

                    )
                )
            }
        }
        .padding(.horizontal,24)
        
    }
}

#Preview {
    ButtonAcceptServiceView(showingAddService: .constant(false))
}
