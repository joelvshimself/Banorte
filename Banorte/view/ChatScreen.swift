import SwiftUI
import Combine

struct ChatScreen: View {
    let transactions: [Transaction]
    @Environment(\.presentationMode) var presentationMode
    @State private var messageText: String = ""
    @State private var messages: [Message] = [
        Message(text: "Hola, soy Maya. ¿En qué puedo ayudarte?", isUser: false)
    ]
    @State private var dragOffset: CGFloat = 0

    // Obtener altura total de la pantalla
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        VStack {
            // Título, ícono y botón de regreso con imagen de fondo
            ZStack {
                Image("fondos")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120 + screenHeight * 0.03)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                
                HStack {
                    // Botón de regresar
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
            .frame(height: 120 + screenHeight * 0.03)
            .offset(y: -20)
            
            // Sección de mensajes
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                } else {
                                    Image(systemName: "bolt.fill")
                                        .foregroundColor(.gray)
                                    Text(message.text)
                                        .padding()
                                        .background(Color(red: 0.937, green: 0.043, blue: 0.161))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                        .id("LastMessage")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .onChange(of: messages.count) { _ in
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
                        // Agregar mensaje del usuario
                        let userMessage = Message(text: messageText, isUser: true)
                        messages.append(userMessage)
                        
                        // Enviar mensaje a la API de OpenAI
                        sendMessageToGPT(message: messageText)
                        
                        messageText = ""
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(Color(red: 0.937, green: 0.043, blue: 0.161))
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
                    if value.translation.width > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                    dragOffset = 0
                }
        )
    }
    
    // Función para enviar el mensaje a la API de OpenAI
    func sendMessageToGPT(message: String) {
        // Asegúrate de almacenar tu API Key de forma segura
        let apiKey = "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"
        
        let endpoint = "https://api.openai.com/v1/chat/completions"
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        // Historial de mensajes para mantener el contexto
        var messagesPayload: [[String: String]] = [
            ["role": "system", "content": "Eres un asistente virtual llamado Maya., te sentrarás en temas de finanzas, te daré mis transacciones para que me puedas dar detalles de mis movimientos y me darás recomedaciones basandote en mi información de manera exclusiva \(transactions)"]
        ]
        
        // Agregar los mensajes anteriores
        for msg in messages {
            let role = msg.isUser ? "user" : "assistant"
            messagesPayload.append(["role": role, "content": msg.text])
        }
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messagesPayload
        ]
        
        guard let url = URL(string: endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error al realizar la solicitud: \(error)")
                return
            }
            
            guard let data = data else {
                print("No se recibieron datos de la API.")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let messageDict = firstChoice["message"] as? [String: Any],
                   let content = messageDict["content"] as? String {
                    
                    DispatchQueue.main.async {
                        let botMessage = Message(text: content.trimmingCharacters(in: .whitespacesAndNewlines), isUser: false)
                        messages.append(botMessage)
                    }
                } else {
                    print("No se pudo analizar la respuesta de la API.")
                }
            } catch {
                print("Error al decodificar la respuesta: \(error)")
            }
        }
        task.resume()
    }
}

// Estructura para representar un mensaje
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

