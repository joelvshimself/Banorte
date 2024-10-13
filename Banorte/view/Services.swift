import SwiftUI

struct Services: View {
    @ObservedObject var connectivityHandler = ConnectivityHandler()

    @State private var messageToSend = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("Connectivity Test")
                .font(.largeTitle)
                .padding()

            if connectivityHandler.isConnected {
                VStack {
                    Text("Connected to: \(connectivityHandler.connectedPeerName)")
                        .font(.headline)
                        .padding()

                    TextField("Enter message", text: $messageToSend)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Send Message") {
                        connectivityHandler.sendMessage(messageToSend)
                        messageToSend = ""  // Clear input after sending
                    }
                    .padding()

                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(connectivityHandler.receivedMessages, id: \.self) { message in
                                Text(message)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                }
            } else {
                VStack {
                    Button("Start Hosting") {
                        connectivityHandler.startHosting()
                    }
                    .padding()

                    Button("Start Browsing for Peers") {
                        connectivityHandler.startBrowsing()
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Start hosting when the view appears
            connectivityHandler.startHosting()
        }
        .alert(isPresented: $connectivityHandler.showConnectionAlert) {
            Alert(title: Text("Connection Established"), message: Text("You are now connected to \(connectivityHandler.connectedPeerName)"), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}
