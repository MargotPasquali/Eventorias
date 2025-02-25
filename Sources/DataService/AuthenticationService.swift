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
    var currentUser: User? { get }
}

final class RemoteAuthenticationService: AuthenticationService {
    static let shared = RemoteAuthenticationService()
    
    private init() {}
    
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
    
    var currentUser: User? {
        guard let firebaseUser = Auth.auth().currentUser else { return nil }
        return convertToUser(firebaseUser)
    }
    
    private func convertToUser(_ firebaseUser: FirebaseAuth.User) -> User {
        return User(uid: firebaseUser.uid, email: firebaseUser.email ?? "", displayName: firebaseUser.displayName)
    }
}
