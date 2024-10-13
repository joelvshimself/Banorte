import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Pantalla principal")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: SecondScreen()) {
                    Text("Ir a la segunda pantalla")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
