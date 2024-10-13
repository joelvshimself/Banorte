import SwiftUI

struct Home: View {
    @ObservedObject var saldoManager = SaldoManager.shared  // Observa el saldo de SaldoManager

    // Ejemplo de datos de transacciones
    let transactions = [
        Transaction(title: "McDonald's", date: "10 OCT • 11:01 am", amount: "$615.12"),
        Transaction(title: "Transferencia a Santiago", date: "10 OCT • 11:01 am", amount: "$1302.97"),
        Transaction(title: "Pemex", date: "10 OCT • 11:01 am", amount: "$1012.38"),
        Transaction(title: "Volkswagen", date: "10 OCT • 11:01 am", amount: "$615.12"),
        Transaction(title: "Cinemex", date: "11 OCT • 08:30 pm", amount: "$240.00"),
        Transaction(title: "Supermercado Aurrerá", date: "11 OCT • 05:00 pm", amount: "$540.75"),
        Transaction(title: "Uber", date: "12 OCT • 07:15 pm", amount: "$180.25"),
        Transaction(title: "Starbucks", date: "12 OCT • 09:00 am", amount: "$95.00"),
        Transaction(title: "Rappi", date: "13 OCT • 12:30 pm", amount: "$450.50"),
        Transaction(title: "Amazon", date: "13 OCT • 04:45 pm", amount: "$850.99"),
        // Agrega más transacciones según sea necesario
        Transaction(title: "Spotify", date: "14 OCT • 09:00 am", amount: "$99.00"),
        Transaction(title: "Netflix", date: "15 OCT • 08:00 am", amount: "$149.00"),
        Transaction(title: "Apple Store", date: "15 OCT • 02:30 pm", amount: "$299.99"),
        Transaction(title: "Gas Natural", date: "16 OCT • 10:45 am", amount: "$350.00"),
        Transaction(title: "CFE", date: "17 OCT • 11:15 am", amount: "$780.50"),
        Transaction(title: "Telcel", date: "18 OCT • 01:20 pm", amount: "$399.00"),
        Transaction(title: "Liverpool", date: "19 OCT • 03:50 pm", amount: "$1,200.00"),
        Transaction(title: "Restaurante El Portón", date: "20 OCT • 07:30 pm", amount: "$650.75"),
        Transaction(title: "OXXO", date: "21 OCT • 09:15 pm", amount: "$200.00"),
        Transaction(title: "Farmacias Guadalajara", date: "22 OCT • 05:40 pm", amount: "$320.60"),
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Barra superior con imagen de fondo
                ZStack {
                    Image("fondos")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                        .edgesIgnoringSafeArea(.top)
                }
                .frame(height: 100)

                // Sección de saldo y botón interactivo con Maya
                VStack {
                    HStack {
                        // Mostrar el saldo actual dinámicamente desde SaldoManager
                        Text(String(format: "$%.2f MN", saldoManager.saldo))
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

                        NavigationLink(destination: ChatScreen(transactions: transactions)) {
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

                // Sección de transacciones con ScrollView y LazyVStack
                VStack(alignment: .leading) {
                    Text("Octubre")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding([.leading, .top], 20)

                    // Agregar ScrollView con altura limitada
                    ScrollView {
                        LazyVStack {
                            ForEach(transactions, id: \.id) { transaction in
                                TransactionRow(title: transaction.title, date: transaction.date, amount: transaction.amount)
                            }
                        }
                    }
                    .frame(height: 300)  // Limitar la altura del ScrollView
                }
                .padding([.top], 20)
                .background(Color.white)  // Fondo blanco para la sección de transacciones

                Spacer()

                // Barra inferior de navegación
                HStack {
                    NavigationButton(imageName: "creditcard", label: "Tarjeta")
                    Spacer()
                    // En tu vista Home, modifica el NavigationLink para pasar las transacciones a ChatScreen
                    NavigationLink(destination: ChatScreen(transactions: transactions)) {
                        NavigationButton(imageName: "bolt.fill", label: "Maya")
                    }

                    Spacer()
                    NavigationLink(destination: TransferScreen(transactions: transactions)) {
                        NavigationButton(imageName: "arrow.left.arrow.right", label: "Transferir")
                    }
                    Spacer()
                    NavigationLink(destination: Services()) {
                        NavigationButton(imageName: "rectangle.stack", label: "Servicios")
                    }
                }
                .padding()
                .background(Color(red: 0.937, green: 0.043, blue: 0.161))
                .foregroundColor(.white)
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)  // Esto oculta el botón "Back"
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Definición de Transaction con Identifiable
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: String
}

// Definición de TransactionRow
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
        .background(Color.white)
    }
}

// Definición de NavigationButton
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
