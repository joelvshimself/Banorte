import SwiftUI

struct ChatScreen: View {
    @Environment(\.presentationMode) var presentationMode  // Permite regresar a la pantalla anterior
    @State private var messageText: String = ""
    @State private var messages: [String] = [
        "Actualmente tienes un balance de $4,752.91 MXN",
        "Invierte 500 en NVIDIA cuando baje a 2500",
        "Claro, necesito que escribas 'Confirmar'"
    ]
    @State private var userMessages: [String] = [] // Mensajes escritos por el usuario
    @State private var dragOffset: CGFloat = 0  // Para gestionar el gesto de arrastre

    // Obtener altura total de la pantalla
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        VStack {
            // Título, ícono y botón de regreso con imagen de fondo
            ZStack {
                Image("fondos") // Imagen de fondo en lugar de color rojo
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120 + screenHeight * 0.03)  // Ajusta la altura de la imagen extendiéndola un 3% más
                    .clipped()  // Recorta la imagen si es más grande que el área
                    .edgesIgnoringSafeArea(.top)  // Extiende el fondo hasta la parte superior de la pantalla
                
                HStack {
                    // Botón de regresar al Main Screen
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text("Maya")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "bolt.circle.fill")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.trailing)
                }
                .padding()
            }
            .frame(height: 120 + screenHeight * 0.03)  // Asegura que el área de la barra tenga la altura ajustada
            .offset(y: -20)  // Mueve la barra superior ligeramente hacia arriba (ajusta el valor si es necesario)
            
            // Sección de mensajes
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        // Mensajes predefinidos del bot
                        ForEach(messages.indices, id: \.self) { index in
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.gray)
                                Text(messages[index])
                                    .padding()
                                    .background(Color(red: 0.937, green: 0.043, blue: 0.161))  // Color #EF0B29 aplicado
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        
                        // Mensajes del usuario
                        ForEach(userMessages.indices, id: \.self) { index in
                            HStack {
                                Spacer()
                                Text(userMessages[index])
                                    .padding()
                                    .foregroundColor(.black) // Sin fondo, solo el texto
                            }
                        }
                        // Ancla para desplazar el scroll hasta la parte inferior
                        .id("LastMessage")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)  // Añade padding en la parte inferior para subir los textos ligeramente
                }
                .onChange(of: userMessages.count) {
                    // Desplaza el scroll hasta el último mensaje cuando se agrega uno nuevo
                    withAnimation {
                        scrollViewProxy.scrollTo("LastMessage", anchor: .bottom)
                    }
                }

            }
            
            // Campo de entrada para enviar mensaje
            HStack {
                TextField("Escribe tu mensaje...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    if !messageText.isEmpty {
                        userMessages.append(messageText)  // Agrega el mensaje del usuario
                        messageText = ""  // Limpia el campo de texto
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(Color(red: 0.937, green: 0.043, blue: 0.161))  // Color #EF0B29 aplicado
                }
                .padding(.trailing)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
        .navigationBarHidden(true)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width > 0 {
                        dragOffset = value.translation.width
                    }
                }
                .onEnded { value in
                    if value.translation.width > 100 {  // Define un umbral para ejecutar la acción
                        presentationMode.wrappedValue.dismiss()  // Vuelve a la pantalla anterior
                    }
                    dragOffset = 0  // Restablece el desplazamiento
                }
        )
    }
}

#Preview {
    ChatScreen()
}
