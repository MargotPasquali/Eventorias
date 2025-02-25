//
//  SwitchTabView.swift
//  Eventorias
//
//  Created by Margot Pasquali on 25/02/2025.
//

import SwiftUI

struct SwitchTabView: View {
    @State private var selectedTab: Tab = .events
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .events:
                        NavigationStack {
                            EventListView()
                                .frame(maxHeight: .infinity)
                        }
                    case .profile:
                        NavigationStack {
                            UserProfileView(viewModel: authViewModel)
                                .frame(maxHeight: .infinity)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                MenuView(selectedTab: $selectedTab)
                    .frame(height: 56)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    SwitchTabView()
        .environmentObject(AuthenticationViewModel())
}
