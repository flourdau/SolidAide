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
//            Spacer()
            
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
            .background(.warmCoral.opacity(0))
            .padding(.bottom, 24)
            
        }
        .padding(.horizontal,24)
        .background(.green.opacity(0))
        
    }
}

#Preview {
    ButtonAcceptServiceView(showingAddService: .constant(false))
}
