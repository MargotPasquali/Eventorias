//
//  AuthenticationService.swift
//  Eventorias
//
//  Created by Margot Pasquali on 21/02/2025.
//

import Foundation
import FirebaseAuth

public protocol AuthenticationService {
    func signUp(email: String, password: String) async throws -> User?
    func signIn(email: String, password: String) async throws -> User?
    func signOut() throws
}

final class RemoteAuthenticationService: AuthenticationService {
    static let shared = RemoteAuthenticationService()
    
    private init() {}
    
    // SignUp
    func signUp(email: String, password: String) async throws -> User? {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return authResult.user
        } catch {
            throw error
        }
    }
    
    // SignIn
    func signIn(email: String, password: String) async throws -> User? {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return authResult.user
        } catch {
            throw error
        }
    }
    
    // SignOut
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
    
    // Vérifier si l'utilisateur est connecté
    var currentUser: User? {
        return Auth.auth().currentUser
    }
}
