import SwiftUI

struct ContentView: View {
    @State private var navigateToHome = false

    var body: some View {
        ZStack {
            // Navegación
            if navigateToHome {
                Home() // Vista a la que se navega después de 3 segundos
            } else {
                ZStack {
                    // Imagen de fondo
                    Image("fondos")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)

                    // Imagen del logo "logo-ban"
                    Image("logo-ban")
                        .resizable()
                        .scaledToFit() // Ajusta la imagen para que mantenga la proporción
                        .frame(width: 200, height: 100) // Ajusta el tamaño de la imagen según sea necesario
                }
                .onAppear {
                    // Navegar a Home después de 3 segundos
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        navigateToHome = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
