import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                // Barra superior con imagen de fondo en lugar de color rojo
                ZStack {
                    Image("fondos") // Cambia "fondo" por el nombre de tu imagen
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)  // Ajusta la altura de la barra de imagen
                        .clipped()  // Recorta la imagen si es más grande que la vista
                        .edgesIgnoringSafeArea(.top)
                }
                .frame(height: 100)  // Asegura que el espacio de la barra sea de 100 de alto

                
                // Sección de saldo y botón interactivo con Maya
                VStack {
                    HStack {
                        Text("$43,752.53 MN")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding([.leading, .trailing], 20)
                    
                    // Botón interactivo con Maya
                    HStack {
                        Image(systemName: "bolt.circle.fill")
                            .foregroundColor(.gray)
                        Text("Interactúa con ")
                            .foregroundColor(.black) +
                        Text("Maya")
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        NavigationLink(destination: ChatScreen()) {
                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 24))
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding([.leading, .trailing], 20)
                }
                .padding(.top, 10)  // Añade espacio superior a la sección del saldo y botón
                .background(Color.white)  // Fondo blanco para esta sección
                
                // Sección de transacciones
                VStack(alignment: .leading) {
                    Text("Octubre")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding([.leading, .top], 20)
                    
                    TransactionRow(title: "McDonald's", date: "10 OCT • 11:01 am", amount: "$615.12")
                    TransactionRow(title: "Transferencia a Santiago", date: "10 OCT • 11:01 am", amount: "$1302.97")
                    TransactionRow(title: "Pemex", date: "10 OCT • 11:01 am", amount: "$1012.38")
                    TransactionRow(title: "Volkswagen", date: "10 OCT • 11:01 am", amount: "$615.12")
                }
                .padding([.top], 20)
                .background(Color.white)  // Fondo blanco para la sección de transacciones
                
                Spacer()
                
                // Barra inferior de navegación con color #EF0B29
                HStack {
                    NavigationButton(imageName: "creditcard", label: "Tarjeta")
                    Spacer()
                    // Navigation Button Maya actualizado con NavigationLink a ChatScreen
                    NavigationLink(destination: ChatScreen()) {
                        NavigationButton(imageName: "bolt.fill", label: "Maya")
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: TransferScreen()) {
                        NavigationButton(imageName: "arrow.left.arrow.right", label: "Transferir")
                    }

                    Spacer()
                    NavigationButton(imageName: "rectangle.stack", label: "Servicios")
                }
                .padding()
                .background(Color(red: 0.937, green: 0.043, blue: 0.161)) // Color #EF0B29 en RGB
                .foregroundColor(.white)
            }
            .background(Color.white)  // Establece fondo blanco para toda la vista
            .navigationBarHidden(true)  // Oculta la barra de navegación superior
        }
    }
}

struct TransactionRow: View {
    let title: String
    let date: String
    let amount: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(amount)
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 10)
        .background(Color.white)  // Fondo blanco para cada fila de transacciones
    }
}

struct NavigationButton: View {
    let imageName: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.title)
            Text(label)
                .font(.caption)
        }
        .frame(width: 70, height: 50)
    }
}

#Preview {
    Home()
}
