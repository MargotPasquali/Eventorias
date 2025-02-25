//
//  LoginViewModel.swift
//  Eventorias
//
//  Created by Margot Pasquali on 21/02/2025.
//

import Foundation
import SwiftUI

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    // MARK: - Enum
    
    enum AuthenticationViewModelError: Error {
        case invalidCredentials
        case authenticationFailed
        case logoutFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidCredentials:
                return "Credentials are invalid. Please try again."
            case .authenticationFailed:
                return "Authentication failed. Please try again."
            case .logoutFailed:
                return "Failed to logout. Please try again."
            }
        }
    }
    
    // MARK: - Properties
    
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var name = ""

    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = RemoteAuthenticationService.shared) {
        self.authService = authService
        checkCurrentUser()
    }
    
    func checkCurrentUser() {
        if let firebaseUser = authService.currentUser {
            isAuthenticated = true
            let user = User(uid: firebaseUser.uid, email: firebaseUser.email, displayName: firebaseUser.displayName)
            self.email = user.email
        } else {
            isAuthenticated = false
            email = ""
        }
    }
    
    func signIn() async {
        isLoading = true
        errorMessage = nil
        
        do {
            if let firebaseUser = try await authService.signIn(email: email, password: password) {
                isAuthenticated = true
                let user = User(uid: firebaseUser.uid, email: firebaseUser.email, displayName: firebaseUser.displayName)
                self.email = user.email
            } else {
                errorMessage = AuthenticationViewModelError.invalidCredentials.localizedDescription
                isAuthenticated = false
            }
        } catch {
            isAuthenticated = false
            errorMessage = AuthenticationViewModelError.authenticationFailed.localizedDescription
        }
        
        isLoading = false
    }
    
    func signOut() {
        do {
            try authService.signOut()
            isAuthenticated = false
            email = ""
            password = ""
        } catch {
            errorMessage = AuthenticationViewModelError.logoutFailed.localizedDescription
        }
    }
}
