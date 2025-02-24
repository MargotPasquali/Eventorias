//
//  UserProfileView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 23/02/2025.
//
import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @State private var notificationsEnabled = false
    
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
                    
                    TextField("", text: .constant(viewModel.name))
                        .padding()
                        .background(Color("Purple"))
                        .cornerRadius(4)
                        .disabled(true)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    
                    TextField("", text: $viewModel.email, prompt: Text(viewModel.email).foregroundColor(.gray))
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
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    UserProfileView(viewModel: AuthenticationViewModel())
}
