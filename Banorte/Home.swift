import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                // Sección de saldo y barra superior
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
                        Text("Interactua con ")
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
                .padding([.top], 50)
                .background(Color.red.opacity(0.9))
                
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
                
                Spacer()
                
                // Barra inferior de navegación
                HStack {
                    NavigationButton(imageName: "creditcard", label: "Tarjeta")
                    Spacer()
                    NavigationButton(imageName: "bolt.fill", label: "Maya")
                    Spacer()
                    NavigationButton(imageName: "arrow.left.arrow.right", label: "Transferir")
                    Spacer()
                    NavigationButton(imageName: "rectangle.stack", label: "Servicios")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
            }
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
