//
//  AddServiceBtnExtView.swift
//  SolidAide
//
//  Created by apprenant78 on 02/11/2025.
//

import SwiftUI
import SwiftData

struct ButtonAddServiceExtView: View {
    @Binding var showingAddService: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                showingAddService = true
            } label: {
                Label("Demander de l'aide", systemImage: "hand.raised.fill")
                    .labelStyle(.titleAndIcon)
                    .padding(16)
                    .padding(.trailing, 8)
                    .background(.deepBlue)
                    .foregroundStyle(.white)
                    .cornerRadius(32)
                    .font(.system(size: 24))
                    .bold()
            }
            .background(.warmCoral.opacity(0))
            .padding(.bottom, 24)
            
        }
        .padding(.horizontal,24)
        .background(.green.opacity(0))
        
    }
}

#Preview {
    ButtonAddServiceExtView(showingAddService: .constant(false))
}
