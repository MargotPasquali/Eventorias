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
                
                VStack(spacing: 20) {
                    Image("Logo Eventorias")
                        .padding(.bottom, 30)
                    
                    Text("Email")
                        .font(Font.custom("Inter-Regular_SemiBold", size: 20))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("", text: $viewModel.email, prompt: Text("Entrez votre email").foregroundColor(.gray))
                        .padding()
                        .background(Color("Purple"))
                        .font(Font.custom("Inter-Regular", size: 16))
                        .cornerRadius(4)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    Text("Password")
                        .foregroundStyle(Color.white)
                        .font(Font.custom("Inter-Regular_SemiBold", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SecureField("", text: $viewModel.password, prompt: Text("Entrez votre mot de passe").foregroundColor(.gray))
                        .font(Font.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color("Purple"))
                        .cornerRadius(4)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.signIn()
                        }
                    }) {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.black)
                        } else {
                            Text("Sign In")
                                .foregroundColor(.black)
                                .font(Font.custom("Inter-Regular_Bold", size: 20))
                                .fontWeight(.bold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .disabled(viewModel.isLoading)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 100)
                .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    EventListView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    LoginView(viewModel: AuthenticationViewModel())
}
