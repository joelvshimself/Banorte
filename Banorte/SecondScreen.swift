import SwiftUI

struct SecondScreen: View {
    var body: some View {
        VStack {
            Text("Segunda pantalla")
                .font(.largeTitle)
                .padding()

            Text("¡Bienvenido a la segunda pantalla!")
                .font(.title)
                .padding()
        }
    }
}

#Preview {
    SecondScreen()
}
