import SwiftUI
import CoreLocation

class SpeedManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    @Published var speed: Double = 0.0
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        // Configuration du gestionnaire de localisation
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // Précision maximale
        locationManager.activityType = .fitness
        locationManager.startUpdatingLocation() // Commence à récupérer la localisation
        
        // Demande de permission d'utilisation de la localisation
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Fonction appelée lorsque la localisation est mise à jour
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // La vitesse est en m/s, il faut la convertir en km/h
            if location.speed > 0 {
                speed = location.speed * 3.6 // Conversion en km/h
            } else {
                speed = 0.0 // Si la vitesse est négative ou non valide
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur de localisation: \(error.localizedDescription)")
    }
}

struct BikeCockpitView: View {
    @State private var distanceLeft: Double = 120.0
    @State private var batteryLevel: Int = 63
    @State private var lineWidth = CGFloat(15)
    @ObservedObject var speedManager = SpeedManager()

    // Formatter pour la date et l'heure
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full   // Affichage complet de la date (ex: Lundi 15 Septembre 2024)
        formatter.timeStyle = .short  // Affichage de l'heure courte (ex: 14:45)
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 30) {
                    Spacer()
            // Formatter pour la date et l'heure
            Text("\(dateFormatter.string(from: Date()))")  // Affichage de la date et heure formatées
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
            Spacer()
            // Cercle avec la vitesse
            ZStack {
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .opacity(0.2)
                    .foregroundColor(.white)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(speedManager.speed / 50.0)) // Adaptation de l'arc de progression à la vitesse max
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: speedManager.speed)
                // Affichage de la vitesse au centre
                VStack {
                    Text("\(Int(speedManager.speed))")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("km/h")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("Adaptive")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 310, height: 390)
            
            Spacer()
            
            Spacer()
            
            // Distance parcourue et batterie
            HStack {
                // Distance
                Text("\(String(format: "%.1f", distanceLeft / 1000)) km")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Batterie avec une jauge circulaire
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.2)
                        .foregroundColor(.gray)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(batteryLevel) / 100.0)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(batteryLevel > 20 ? .green : .red)
                        .rotationEffect(Angle(degrees: 270))
                        .animation(.linear)
                    
                    VStack {
                        Text("\(batteryLevel)%")
                            .font(.title2)
                            .foregroundColor(batteryLevel > 20 ? .green : .red)
                    }
                }
                .frame(width: 60, height: 60)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Menu des contrôles avec animations et meilleure ergonomie
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

// Sous-vue pour les boutons de contrôle avec amélioration du design
struct ControlButtonView: View {
    var imageName: String
    var title: String
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColor)
                .clipShape(Circle())  // Rond pour un look plus moderne
                .shadow(radius: 10)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
        .frame(width: 70, height: 100)  // Meilleure ergonomie
        .onTapGesture {
            // Animation lors de l’appui
            withAnimation(.easeInOut(duration: 0.2)) {
                // Action associée au bouton
            }
        }
    }
}

struct BikeCockpitView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCockpitView()
    }
}
