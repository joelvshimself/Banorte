import Foundation
import MultipeerConnectivity
import SwiftUI

class ConnectivityHandler: NSObject, ObservableObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {

    private let peerID = MCPeerID(displayName: UIDevice.current.name)
    private let serviceType = "example-service"
    @ObservedObject var saldoManager = SaldoManager.shared
    
    private var session: MCSession!
    private var advertiser: MCNearbyServiceAdvertiser!
    private var browser: MCNearbyServiceBrowser!
    
    @Published var isConnected = false
    @Published var connectedPeerName = ""
    @Published var receivedMessages: [String] = []
    @Published var showConnectionAlert = false

    override init() {
        super.init()
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        advertiser.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        browser.delegate = self
    }
    
    // Start hosting (advertising)
    func startHosting() {
        advertiser.startAdvertisingPeer()
    }
    
    // Start browsing for peers
    func startBrowsing() {
        browser.startBrowsingForPeers()
    }
    
    func sendMessage(_ message: String) {
        if session.connectedPeers.count > 0 {
            if let data = message.data(using: .utf8) {
                if let cantidad = Int(message) {
                    if SaldoManager.shared.saldo >= Double(cantidad) {
                        SaldoManager.shared.afectarSaldo(cantidad: -Double(cantidad))
                        try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
                        print("Nuevo saldo después de enviar \(cantidad): \(SaldoManager.shared.saldo)")
                    } else {
                        print("Saldo insuficiente para enviar \(cantidad).")
                        // Aquí puedes agregar una alerta para el usuario
                    }
                } else {
                    print("El mensaje a enviar no es un número válido.")
                    // Puedes decidir si quieres enviar mensajes que no sean números
                    try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
                }
            }
        }
    }

    
    // Disconnect from session and stop advertising and browsing
    func disconnect() {
        advertiser.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
        session.disconnect()
        isConnected = false
        connectedPeerName = ""
        print("Disconnected from session and stopped advertising and browsing.")
    }
    
    // MARK: - MCSessionDelegate Methods
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            switch state {
            case .connected:
                self.isConnected = true
                self.connectedPeerName = peerID.displayName
                self.showConnectionAlert = true // Trigger alert
            case .connecting:
                self.isConnected = false
            case .notConnected:
                self.isConnected = false
            @unknown default:
                fatalError("Unknown state encountered")
            }
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            if let message = String(data: data, encoding: .utf8) {
                // Añadir el mensaje a la lista de mensajes recibidos
                self.receivedMessages.append("\(peerID.displayName): \(message)")
                
                // Intentar parsear el mensaje a un entero
                if let cantidad = Int(message) {
                    // Llamar a la funcionalidad de afectar saldo en el singleton
                    SaldoManager.shared.afectarSaldo(cantidad: Double(cantidad))
                    
                    // Mostrar el nuevo saldo para depuración
                    print("Nuevo saldo después de recibir \(cantidad): \(SaldoManager.shared.saldo)")
                } else {
                    print("El mensaje recibido no es un número válido.")
                }
            }
        }
    }

    
    // Required delegate methods with no implementation needed for now
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
    
    // MARK: - MCNearbyServiceAdvertiserDelegate Methods
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session) // Automatically accept invitation
    }
    
    // MARK: - MCNearbyServiceBrowserDelegate Methods
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {}
}
