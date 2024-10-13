import SwiftUI
import UserNotifications

struct TransferScreen: View {
    @State private var amount: String = ""
    @State private var recipient: String = ""
    
    // Estado para controlar la presentación del Alert
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                // Barra superior con imagen de fondo
                ZStack {
                    Image("fondos") // Cambia "fondos" por el nombre de tu imagen
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)  // Ajusta la altura de la barra de imagen
                        .clipped()  // Recorta la imagen si es más grande que la vista
                        .edgesIgnoringSafeArea(.top)
                }
                .frame(height: 100)  // Asegura que el espacio de la barra sea de 100 de alto

                // Sección de transferencia
                VStack(spacing: 20) {
                    Text("Transferencia de dinero")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding()

                    // Campo de destinatario
                    HStack {
                        Text("Destinatario:")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        TextField("Nombre o cuenta", text: $recipient)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(.horizontal, 20)

                    // Campo de monto
                    HStack {
                        Text("Monto:")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                        TextField("Monto a transferir", text: $amount)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(width: 200)
                    }
                    .padding(.horizontal, 20)

                    // Botón de confirmar transferencia
                    Button(action: {
                        // Lógica para confirmar transferencia
                        print("Transferencia realizada a \(recipient) por \(amount)")
                        // Programar una notificación local
                        scheduleLocalNotification()
                    }) {
                        Text("Confirmar transferencia")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.937, green: 0.043, blue: 0.161)) // Color #EF0B29
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)

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
                    
                    NavigationButton(imageName: "arrow.left.arrow.right", label: "Transferir")

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
        .onAppear {
            // Solicitar permisos para notificaciones locales
            requestNotificationPermission()
        }
    }

    // Solicitar permiso para enviar notificaciones locales
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permiso para notificaciones locales concedido.")
            } else {
                print("Permiso para notificaciones locales denegado.")
            }
        }
    }

    // Programar una notificación local
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Transferencia Exitosa"
        content.body = "Tu transferencia de \(amount) a \(recipient) fue completada."
        content.sound = UNNotificationSound.default

        // Configurar el trigger de la notificación (se muestra después de 1 segundo)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // Crear la solicitud de notificación
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Agregar la notificación al centro de notificaciones
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al programar notificación: \(error)")
            }
        }
    }
}

#Preview {
    TransferScreen()
}
