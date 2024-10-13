import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    // Método que se ejecuta al iniciar la aplicación
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        
        // Solicitar autorización para recibir notificaciones
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }

        // Afectar el saldo inicial desde el AppDelegate
        SaldoManager.shared.setSaldo(1000.0)  // Establecer el saldo inicial en 1000
        
        // Opcional: Log de saldo inicial
        print("Saldo inicial: \(SaldoManager.shared.getSaldo())")
        
        return true
    }

    // Método que se ejecuta cuando el registro de notificaciones push es exitoso
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }

    // Método que se ejecuta cuando falla el registro para notificaciones push
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    // Manejar la notificación cuando la app está en primer plano
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Mostrar la notificación en forma de banner, sonido y badge
        completionHandler([.banner, .sound, .badge])
    }
}
