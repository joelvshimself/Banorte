import Foundation

class SaldoManager: ObservableObject {
    static let shared = SaldoManager()  // Singleton

    @Published var saldo: Double {
        didSet {
            UserDefaults.standard.set(saldo, forKey: "saldo")  // Guardar el saldo cada vez que cambie
        }
    }

    private init() {
        // Recuperar el saldo de UserDefaults o establecer a 1000 si no existe
        self.saldo = UserDefaults.standard.double(forKey: "saldo")
        if self.saldo == 0 {
            self.saldo = 1000  // Saldo inicial solo la primera vez
        }
    }

    // Función para afectar (añadir o restar) el saldo
    func afectarSaldo(cantidad: Double) {
        saldo += cantidad
        print("Nuevo saldo: \(saldo)")
    }

    // Función para establecer el saldo a un valor específico
    func setSaldo(_ nuevoSaldo: Double) {
        saldo = nuevoSaldo
        print("Saldo establecido en: \(saldo)")
    }
}
