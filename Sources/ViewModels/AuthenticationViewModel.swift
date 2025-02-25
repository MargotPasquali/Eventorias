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
    enum AuthenticationViewModelError: Error {
        case invalidCredentials
        case authenticationFailed
        case logoutFailed
        case updateProfileFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidCredentials:
                return "Credentials are invalid. Please try again."
            case .authenticationFailed:
                return "Authentication failed. Please try again."
            case .logoutFailed:
                return "Failed to logout. Please try again."
            case .updateProfileFailed:
                return "Failed to update profile. Please try again."
            }
        }
    }
    
    private let authService: AuthenticationService
    
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var name = ""
    
    init(authService: AuthenticationService = RemoteAuthenticationService.shared) {
        self.authService = authService
        checkCurrentUser()
    }
    
    func checkCurrentUser() {
        if let firebaseUser = authService.currentUser {
            isAuthenticated = true
            let user = User(uid: firebaseUser.uid, email: firebaseUser.email, displayName: firebaseUser.displayName)
            self.email = user.email
            self.name = user.displayName ?? ""
        } else {
            isAuthenticated = false
            email = ""
            name = ""
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
                self.name = user.displayName ?? ""
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
            name = ""
        } catch {
            errorMessage = AuthenticationViewModelError.logoutFailed.localizedDescription
        }
    }
    
    func updateUserName(newName: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await authService.updateUserName(newName: newName)
            self.name = newName // Met à jour localement
            checkCurrentUser() // Rafraîchit les données
        } catch RemoteAuthenticationService.AuthenticationServiceError.userNotLoggedIn {
            errorMessage = RemoteAuthenticationService.AuthenticationServiceError.userNotLoggedIn.localizedDescription
        } catch {
            errorMessage = AuthenticationViewModelError.updateProfileFailed.localizedDescription
        }
        
        isLoading = false
    }
}
