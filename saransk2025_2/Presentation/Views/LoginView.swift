//
//  LoginView.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 04.04.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var model = LoginViewModel()
    var body: some View {
        VStack {
            Topbar(header: "Login", isBackable: true)
            Image("lah")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 135)
                .padding(.top, 24)
                
            Text("For free, join now and start learning")
                .multilineTextAlignment(.center)
                .font(size: 22, weight: .medium, foreground: .dark)
                .padding(.horizontal, 56)
                .padding(.bottom, 32)
            VStack {
                CustomTextField(label: "Email address", placeholder: "Email", text: $model.email, isSecure: false)
                    .padding(.bottom, 24)
                CustomTextField(label: "Password", placeholder: "", text: $model.password, isSecure: true)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            HStack {
                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Forgot Password")
                        .font(size: 15, weight: .regular, foreground: .cRed)
                }
                Spacer()
            }
            .padding(.horizontal, 26)
            .padding(.bottom, 8)
            Button {
                model.login2()
            } label: {
                Text("Login")
            }
            .buttonStyle(MainButtonStyle())
            .padding( 24)
            HStack {
                Text(model.isConnected ? "Подключен" : "Не подключен")
                Text("Not you member?")
                    .font(size: 17, weight: .regular, foreground: .dGray)

                NavigationLink {
                    SignUpFirstView().navigationBarBackButtonHidden()
                } label: {
                    Text("Signup")
                        .font(size: 17, weight: .medium, foreground: .cBlue)
                }

            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea(.all)
        .onAppear {
            
        }
        .notConnecting(connection: model.isConnected)
        .onLoadingProccess(isLoading: model.isLoading)
    }
}

#Preview {
    LoginView()
}
