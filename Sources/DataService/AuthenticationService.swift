//
//  AuthenticationService.swift
//  Eventorias
//
//  Created by Margot Pasquali on 21/02/2025.
//

import FirebaseAuth

protocol AuthenticationService {
    func signUp(email: String, password: String) async throws -> User?
    func signIn(email: String, password: String) async throws -> User?
    func signOut() throws
    func updateUserName(newName: String) async throws
    var currentUser: User? { get }
}

final class RemoteAuthenticationService: AuthenticationService {
    static let shared = RemoteAuthenticationService()
    
    private init() {}
    
    enum AuthenticationServiceError: Error {
        case userNotLoggedIn
        case profileUpdateFailed
        
        var localizedDescription: String {
            switch self {
            case .userNotLoggedIn:
                return "User disconnected"
            case .profileUpdateFailed:
                return "Profile update failed. Please try again later."
            }
        }
    }
    
    func signUp(email: String, password: String) async throws -> User? {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return convertToUser(authResult.user)
    }
    
    func signIn(email: String, password: String) async throws -> User? {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return convertToUser(authResult.user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func updateUserName(newName: String) async throws {
        
        guard let user = Auth.auth().currentUser else {
            throw AuthenticationServiceError.userNotLoggedIn
        }
        
        let request = user.createProfileChangeRequest()
        request.displayName = newName
        
        // Wait for Firebase to save the new name
        try await Task {
            try await request.commitChanges()
        }.value
    }
    
    var currentUser: User? {
        guard let firebaseUser = Auth.auth().currentUser else { return nil }
        return convertToUser(firebaseUser)
    }
    
    private func convertToUser(_ firebaseUser: FirebaseAuth.User) -> User {
        return User(uid: firebaseUser.uid, email: firebaseUser.email ?? "", displayName: firebaseUser.displayName)
    }
}
