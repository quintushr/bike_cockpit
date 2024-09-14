import SwiftUI
import CoreLocation

class SpeedManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    @Published var speed: Double = 0.0
    @Published var totalDistance: Double = 0.0  // Distance totale parcourue en km
    
    private var lastLocation: CLLocation?  // Stocker la dernière localisation connue
    
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
            // Calcul de la vitesse (en km/h)
            if location.speed > 0 {
                speed = location.speed * 3.6 // Conversion de m/s en km/h
            } else {
                speed = 0.0
            }
            
            // Calcul de la distance parcourue
            if let lastLocation = lastLocation {
                let distance = location.distance(from: lastLocation) / 1000.0  // Distance en kilomètres
                totalDistance += distance
            }
            
            // Met à jour la dernière localisation connue
            lastLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur de localisation: \(error.localizedDescription)")
    }
}

struct BikeCockpitView: View {
    @State private var distanceLeft: Double = 120.0
    let maxSpeed: Double = 50.0 // Vitesse max (pour le cercle)
    let markerStep: Double = 2.5 // Intervalle des repères en km/h
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
                
                // Cercle de progression de la vitesse
                Circle()
                    .trim(from: 0.0, to: CGFloat(speedManager.speed / maxSpeed)) // Adaptation de l'arc de progression
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: speedManager.speed)
                
                // Affichage de la vitesse au centre
                VStack {
                    Text("\(Int(speedManager.speed))")
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("km/h")
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 310, height: 390)
            
            Spacer()
            
            Spacer()
            
            // Distance parcourue et bouton de paramétrage (sans texte)
            HStack {
                // Distance
                Text("\(String(format: "%.1f", speedManager.totalDistance)) km")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Bouton de paramétrage sans texte
                Button(action: {
                    // Action lors de l'appui sur le bouton de paramétrage
                    print("Paramètres appuyé")
                }) {
                    Image(systemName: "gearshape")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())  // Bouton circulaire
                        .shadow(radius: 10)
                }
                .frame(width: 60, height: 60)  // Taille du bouton
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct BikeCockpitView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCockpitView()
    }
}
