//
//  BanorteApp.swift
//  Banorte
//
//  Created by Joel Vargas on 12/10/24.
//

import SwiftUI

@main
struct BanorteApp: App {
    // Vincula el AppDelegate con SwiftUI
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var transactionsManager = TransactionsManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
