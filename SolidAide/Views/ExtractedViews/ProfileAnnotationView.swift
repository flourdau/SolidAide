import SwiftUI
import SwiftData

// ---------------------------------------------------------------
//  ProfileAnnotationView – affichage d’une annotation sur la carte
// ---------------------------------------------------------------
struct ProfileAnnotationView: View {
    @Query(filter: #Predicate<UserClass> { user in
        user.logIn == "severine@email.fr"
    }) var usersFound: [UserClass]
    let profile: ProfileClass
    @State private var offset: CGSize = .zero
    @State private var isToggled = false
    
    var body: some View {
        Button {
            isToggled.toggle()
        } label: {
            VStack(alignment: .center) {
                if isToggled {
                    if let service = profile.serviceId?.first {
                        NavigationLink(
                            destination: ServiceDetailView(
                                service: service,
                                user: usersFound[0]
                            )
                        ) {
                            HStack {
                                Text(service.serviceDescription)
                                    .frame(maxWidth: .infinity)
                                    .padding(12)
                                    .foregroundColor(.white)
                                    .background(
                                        Color(.mintGreen.opacity(0.95)),
                                        in: UnevenRoundedRectangle(
                                            topLeadingRadius: 16,
                                            bottomLeadingRadius: 16,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 16)
                                    )
                                Image(systemName: service.skill.icon)
                                    .bold()
                                    .padding(8)
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .background(
                                        Color(.goldenYellow.opacity(0.95)),
                                        in: UnevenRoundedRectangle(
                                            topLeadingRadius: 16,
                                            bottomLeadingRadius: 16,
                                            bottomTrailingRadius: 0,
                                            topTrailingRadius: 16)
                                    )
                                    .offset(x:-32, y:-24)
                            }
                            
                        }
                        .buttonStyle(.plain)
                    } else {
                        Text("Info")
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(
                                Color(.mintGreen.opacity(0.95)),
                                in: UnevenRoundedRectangle(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 16)
                            )
                    }
                }
                
                Image(systemName: "figure.wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.warmCoral)
            }
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in offset = value.translation }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity)
    }
}
