//
//  AuthenticationService.swift
//  EventoriasDataService
//
//  Created by Margot Pasquali on 21/02/2025.
//

import Foundation
import FirebaseAuth

public protocol AuthenticationService {
    func signIn(email: String, password: String) -> AnyPublisher<User, Error>
    func signUp(email: String, password: String) -> AnyPublisher<User, Error>
    func signOut()
}
