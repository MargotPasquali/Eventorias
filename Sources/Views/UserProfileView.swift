//
//  UserProfileView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 23/02/2025.
//

import SwiftUI

struct UserProfileView: View {

    // MARK: - Properties
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var notificationsEnabled = false

    // MARK: - View
    var body: some View {

        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    HStack {
                        Text("User Profile")
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(Color("BrownPurple"))
                    }
                    .padding(.horizontal, 10.0)
                    
                    Text(viewModel.name.isEmpty ? "Non défini" : viewModel.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color("Purple"))
                        .cornerRadius(4)
                        .foregroundColor(.white)
                    
                    Text(viewModel.email)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color("Purple"))
                        .cornerRadius(4)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.white)
                    
                    HStack {
                        Toggle("", isOn: $notificationsEnabled)
                            .tint(Color("CustomRed"))
                            .labelsHidden()
                            .padding(.trailing, 10.0)
                        Text("Notifications")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button(action: {
                        Task {
                            viewModel.signOut()
                        }
                    }) {
                        Text("Sign Out")
                            .foregroundColor(Color("BrownPurple"))
                            .font(Font.custom("Inter-Regular", size: 16))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("BackgroundColor"))
                    .border(Color("Purple"), width: 3)
                    .cornerRadius(8)
                    .disabled(viewModel.isLoading)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.checkCurrentUser()
        }
    }
}

#Preview {
    UserProfileView(viewModel: AuthenticationViewModel())
}
