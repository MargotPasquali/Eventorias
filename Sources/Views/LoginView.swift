//
//  ContentView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 21/02/2025.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Text("Email")
                        .foregroundStyle(Color.white)
                    
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    Text("Password")
                        .foregroundStyle(Color.white)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    Button(action: {
                        viewModel.signIn()
                    }) {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    LoginView(viewModel: AuthenticationViewModel())
}
