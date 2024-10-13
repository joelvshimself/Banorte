import SwiftUI

// Definición del tipo Particle
struct Particle: Identifiable {
    let id = UUID()  // Identificador único
    var x: CGFloat   // Posición en X
    var y: CGFloat   // Posición en Y
    var size: CGFloat  // Tamaño de la partícula
    var opacity: Double  // Opacidad de la partícula
}

struct ContentView: View {
    @State private var particles: [Particle] = []
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            // Navegación
            if navigateToHome {
                Home() // Vista a la que se navega después de 3 segundos
            } else {
                ZStack {
                    // Fondo rojo
                    Color.red
                        .edgesIgnoringSafeArea(.all)
                    
                    // Partículas
                    ForEach(particles) { particle in
                        Circle()
                            .frame(width: particle.size, height: particle.size)
                            .foregroundColor(.white)
                            .opacity(particle.opacity)
                            .position(x: particle.x, y: particle.y)
                            .onAppear {
                                withAnimation(
                                    Animation.linear(duration: Double.random(in: 5...10))
                                        .repeatForever(autoreverses: false)
                                ) {
                                    moveParticle(particle)
                                }
                            }
                    }
                    
                    // Texto Banorte
                    Text("Banorte")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .onAppear {
                    generateParticles()
                    // Navegar a Home después de 3 segundos
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        navigateToHome = true
                    }
                }
            }
        }
    }

    // Función para mover las partículas
    private func moveParticle(_ particle: Particle) {
        if let index = particles.firstIndex(where: { $0.id == particle.id }) {
            particles[index].y = CGFloat.random(in: -50...UIScreen.main.bounds.height)
            particles[index].x = CGFloat.random(in: -50...UIScreen.main.bounds.width)
        }
    }
    
    // Genera partículas aleatorias
    private func generateParticles() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        for _ in 0..<100 {
            let particle = Particle(
                x: CGFloat.random(in: 0...screenWidth),
                y: CGFloat.random(in: 0...screenHeight),
                size: CGFloat.random(in: 5...15),
                opacity: Double.random(in: 0.2...1.0)
            )
            particles.append(particle)
        }
    }
}



#Preview {
    ContentView()
}
