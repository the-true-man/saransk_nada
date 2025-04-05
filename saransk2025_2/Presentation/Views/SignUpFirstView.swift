//
//  SignOnView.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import SwiftUI

struct SignUpFirstView: View {
    @StateObject var model = SignUpViewModel()
    var body: some View {
        VStack {
            Topbar(header: "Signoup", isBackable: true)
            Text("Create an Account")
                .padding(.horizontal, 56)
                .padding(.bottom, 32)
                .padding(.top, 40)
                .font(size: 22, weight: .medium, foreground: .dark)
            VStack(spacing: 24) {
                CustomTextField(label: "First Name", placeholder: "Your First Name", text: $model.firstName, isSecure: false)
                CustomTextField(label: "Last Name", placeholder: "Your Last Name", text: $model.lastName, isSecure: false)
                CustomTextField(label: "Email Address", placeholder: "Email", text: $model.firstName, isSecure: false)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
            NavigationLink {
                SignUpSecondView(model: model)
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Continue")
                
            }
            .buttonStyle(MainButtonStyle())
            .padding(.vertical, 24)
            .padding(.horizontal, 24)
            
            HStack {
                Text("Already you member?")
                    .font(size: 17, weight: .regular, foreground: .dGray)
                NavigationLink {
                    LoginView().navigationBarBackButtonHidden()
                } label: {
                      Text("Login")
                        .font(size: 17, weight: .medium, foreground: .cBlue)

                }

            }
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SignUpFirstView()
}
