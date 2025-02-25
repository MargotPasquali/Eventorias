//
//  EventoriasApp.swift
//  Eventorias
//
//  Created by Margot Pasquali on 21/02/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Configure App Check avec le fournisseur de débogage
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        return true
    }
    
    
}

@main
struct EventoriasApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    var body: some Scene {
            WindowGroup {
                NavigationStack {
                    if authViewModel.isAuthenticated {
                        SwitchTabView()
                            .environmentObject(authViewModel)
                    } else {
                        WelcomeView()
                            .environmentObject(authViewModel)
                    }
                }
            }
        }
}
