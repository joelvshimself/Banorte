import SwiftUI

import SwiftUI

struct ChatScreen: View {
    @State private var messageText: String = ""
    @State private var messages: [String] = [
        "Actualmente tienes un balance de $4,752.91 MXN",
        "Invierte 500 en NVIDIA cuando baje a 2500",
        "Claro, necesito que escribas 'Confirmar'"
    ]
    
    var body: some View {
        VStack {
            // Título y encabezado
            VStack {
                HStack {
                    Image(systemName: "bolt.circle.fill")
                        .foregroundColor(.gray)
                    Text("Maya")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding()
                .background(Color.red.opacity(0.9))
                
                Spacer(minLength: 20)
            }
            
            // Sección de mensajes
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages, id: \.self) { message in
                        HStack {
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.gray)
                            Text(message)
                                .padding()
                                .background(Color.red.opacity(0.9))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Campo de entrada para enviar mensaje
            HStack {
                TextField("Escribe tu mensaje...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                
                Button(action: {
                    if !messageText.isEmpty {
                        messages.append(messageText)
                        messageText = ""
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.red)
                }
                .padding(.trailing)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ChatScreen()
}

