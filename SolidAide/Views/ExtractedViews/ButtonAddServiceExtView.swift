//
//  AddServiceBtnExtView.swift
//  SolidAide
//
//  Created by apprenant78 on 02/11/2025.
//

import SwiftUI

struct ButtonAddServiceExtView: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Label("Demander de l'aide", systemImage: "hand.raised.fill")
                        .labelStyle(.automatic)
                        .padding(16)
                        .padding(.trailing, 8)
                        .background(.deepBlue)
                        .foregroundStyle(.white)
                        .cornerRadius(32)
                        .font(.system(size: 24))
                        .bold()
                }
                .padding(.bottom, 24)
            
            }.padding(.horizontal,24)

        }
    }
}
#Preview {
    ButtonAddServiceExtView()
}
