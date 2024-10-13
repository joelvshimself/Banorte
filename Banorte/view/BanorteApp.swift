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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
