//
//  WelcomeView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 22/02/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack(spacing: 50) {
                    Image("Logo Eventorias")
                        .padding(.bottom, 10.0)
                    NavigationLink(destination: LoginView(viewModel: AuthenticationViewModel())
                        .navigationBarBackButtonHidden(true)
                    ) {
                        HStack {
                            Image("email")
                                .foregroundColor(.white)
                                .padding(.trailing, 5.0)
                            Text("Sign in with email")
                                .foregroundColor(.white)
                                .font(Font.custom("Inter-Regular_Bold", size: 16))
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("CustomRed"))
                        .cornerRadius(4)
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                }.padding()
                .padding(.top, 100)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
