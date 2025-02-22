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
    
    // MARK: - Properties
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var email = ""
    @Published var password = ""
    
    private let authService: AuthenticationService
    
    // MARK: - Init
    init(authService: AuthenticationService = RemoteAuthenticationService.shared) {
        self.authService = authService
    }
    
    func signUp(email: String, password: String) {
        Task {
            do {
                let user = try await authService.signUp(email: email, password: password)
                isAuthenticated = user != nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func signIn() {
        Task {
            do {
                let user = try await authService.signIn(email: email, password: password)
                isAuthenticated = user != nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func signOut() {
        do {
            try authService.signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
