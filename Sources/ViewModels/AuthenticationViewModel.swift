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
    }
    
    func signIn() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signIn(email: email, password: password)
            if user != nil {
                isAuthenticated = true
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
        } catch {
            errorMessage = AuthenticationViewModelError.logoutFailed.localizedDescription
        }
    }
}
