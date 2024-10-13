import Foundation

class SaldoManager {
    static let shared = SaldoManager()  // Singleton

    private var saldo: Double = 0.0  // Variable para el saldo

    private init() {}  // Constructor privado para evitar la creación de más instancias

    // Función para obtener el saldo actual
    func getSaldo() -> Double {
        return saldo
    }

    // Función para afectar (añadir o restar) el saldo
    func afectarSaldo(cantidad: Double) {
        saldo += cantidad
        print("Nuevo saldo: \(saldo)")  // Para depuración
    }

    // Función para establecer el saldo a un valor específico
    func setSaldo(_ nuevoSaldo: Double) {
        saldo = nuevoSaldo
        print("Saldo establecido en: \(saldo)")  // Para depuración
    }
}
