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
            
            Button {
                showingAddService = true
            } label: {
                HStack{
                    Image(systemName:"hand.raised.fill")
                        .padding(.trailing, 8)

                    VStack{
                        Text("Demander")
                        Text("de l'aide")
                    }
                    .padding(.trailing, 8)

                }
                .padding(12)
                .background(.deepBlue)
                .foregroundStyle(.white)
                .cornerRadius(32)
                .font(.system(size: 18))
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
