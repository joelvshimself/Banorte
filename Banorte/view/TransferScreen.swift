import SwiftUI
import MultipeerConnectivity

struct TransferScreen: View {
    let transactions: [Transaction]  // Recibe las transacciones
    @Environment(\.presentationMode) var presentationMode  // Para manejar la acción de regresar
    @State private var amount: String = ""
    @ObservedObject var connectivityHandler = ConnectivityHandler()
    
    @State private var showAlert = false
    @State private var receivedAmount: String = ""

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

                // Sección de transferencia
                VStack(spacing: 20) {
                    Text("Transferencia de dinero")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding()

                    // Campo de destinatario
                    HStack {
                        Spacer()
                        HStack {
                            // Círculo estilizado para el destinatario
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)
                                
                                Text(connectivityHandler.connectedPeerName.prefix(2)) // Mostrar iniciales del peer
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                            }

                            Text(connectivityHandler.connectedPeerName.isEmpty ? "Esperando conexión..." : connectivityHandler.connectedPeerName)
                                .font(.headline)
                                .foregroundColor(.gray)
                                .frame(width: 200)
                                .padding(.leading, 10)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Campo de monto
                    HStack {
                        Text("Monto:")
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Monto a transferir", text: $amount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(width: 200)
                    }
                    .frame(maxWidth: .infinity, alignment: .center) // Centrar el HStack
                    .padding(.horizontal, 20)

                    // Botón de confirmar transferencia
                    Button(action: {
                        // Validar que el monto sea un número válido
                        if let monto = Double(amount), monto > 0 {
                            // Enviar la cantidad a través de la conectividad
                            connectivityHandler.sendMessage(amount)
                            print("Transferencia realizada a \(connectivityHandler.connectedPeerName) por \(amount)")
                        } else {
                            // Manejar entrada inválida
                            print("Monto inválido")
                        }
                    }) {
                        Text("Confirmar transferencia")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.937, green: 0.043, blue: 0.161))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20) // Agregado padding inferior

                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)

                Spacer()

                // Barra inferior de navegación
                HStack {
                    // Botón "Home" como botón de regresar
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()  // Acción de regresar
                    }) {
                        NavigationButton(imageName: "house.fill", label: "Home")
                    }
                    
                    Spacer()
                    
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Transferencia recibida"),
                    message: Text("Has recibido una transferencia de \(receivedAmount)"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                // Empezar a buscar conexiones cuando aparece la vista
                connectivityHandler.startHosting()
                connectivityHandler.startBrowsing()
            }
            .onDisappear {
                // Desconectar cuando la vista desaparece
                connectivityHandler.disconnect()
            }
            .onReceive(connectivityHandler.$receivedMessages) { messages in
                if let lastMessage = messages.last {
                    receivedAmount = lastMessage
                    showAlert = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Componente reutilizable para los botones de la barra de navegación inferior
    struct NavigationButton: View {  // Renombrado a NavigationButton para consistencia
        var imageName: String
        var label: String

        var body: some View {
            VStack {
                Image(systemName: imageName)
                    .font(.title)
                Text(label)
                    .font(.footnote)
            }
        }
    }
}


