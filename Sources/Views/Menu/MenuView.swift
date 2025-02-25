//
//  MenuView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 25/02/2025.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedTab: Tab
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("BackgroundColor"))
                .frame(maxWidth: .infinity, maxHeight: 56)
            
            HStack(spacing: 0) {
                Button(action: {
                    selectedTab = .events
                }) {
                    VStack {
                        Image(selectedTab == .events ? "IconEvent_Red" : "IconEvent_White")
                            .resizable()
                            .frame(width: 15, height: 16)
                            .padding(.bottom, 5)
                        Text("Events")
                            .foregroundColor(selectedTab == .events ? Color("CustomRed") : .white)
                            .font(Font.custom("Inter-Regular_SemiBold", size: 12))
                    }
                    .padding(.horizontal, 15)
                }
                
                Button(action: {
                    selectedTab = .profile
                }) {
                    VStack {
                        Image(selectedTab == .profile ? "IconProfile_Red" : "IconProfile_White")
                            .resizable()
                            .frame(width: 15, height: 16)
                            .padding(.bottom, 5)
                        Text("Profile")
                            .foregroundColor(selectedTab == .profile ? Color("CustomRed") : .white)
                            .font(Font.custom("Inter-Regular_SemiBold", size: 12))
                    }
                    .padding(.horizontal, 15)
                }
            }
            .frame(maxWidth: .infinity)
            .animation(.easeInOut, value: selectedTab)
        }
    }
}

#Preview {
    MenuView(selectedTab: .constant(.events))
        .frame(maxWidth: .infinity)
        .environmentObject(AuthenticationViewModel())
}
