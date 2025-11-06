import SwiftUI
import CoreImage.CIFilterBuiltins

struct ParrainageView: View {
    // -----------------------------------------------------------------
    // 1️⃣  Génération d’un QR‑code factice (texte « solid-aide‑demo »)
    // -----------------------------------------------------------------
    private let qrData = "solid-aide-demo".data(using: .utf8)!
    
    private var qrImage: Image {
        let context = CIContext()
        let filter  = CIFilter.qrCodeGenerator()
        filter.message = qrData
        
        // Le QR‑code brut (CIImage)
        guard let output = filter.outputImage else { return Image(systemName: "xmark.circle") }
        
        // Agrandir le QR‑code pour qu’il soit net à l’écran
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaled    = output.transformed(by: transform)
        
        // Convertir en CGImage puis en SwiftUI Image
        if let cgImg = context.createCGImage(scaled, from: scaled.extent) {
            return Image(decorative: cgImg, scale: 1.0)
        } else {
            return Image(systemName: "xmark.circle")
        }
    }
    
    // -----------------------------------------------------------------
    // 2️⃣  Corps de la vue
    // -----------------------------------------------------------------
    var body: some View {
        VStack(spacing: 32) {
            // -------------------------------------------------------------
            // Titre d’invitation
            // -------------------------------------------------------------
            Text("Scannez pour télécharger Solid'Aide")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
            
            // -------------------------------------------------------------
            // QR‑code (centré, carré)
            // -------------------------------------------------------------
            qrImage
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 4)
            
            // -------------------------------------------------------------
            // Bouton « Inviter un utilisateur » (style DeepBlue)
            // -------------------------------------------------------------
            Button(action: {
                
            }) {
                Text("Inviter un utilisateur")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("deepBlue"))
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .padding(.top, 48)
        .navigationTitle("Parrainage")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

