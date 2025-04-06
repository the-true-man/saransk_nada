//
//  SignUpSecondVIew.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import SwiftUI

struct SignUpSecondView: View {
    @StateObject var model: SignUpViewModel
    var body: some View {
        VStack {
            Topbar(header: "Signup", isBackable: true)
            Text("Choose a Password")
                .font(size: 22, weight: .medium, foreground: .dark)
                .padding(.horizontal, 56)
                .padding(.top, 40)
                .padding(.bottom, 32)
            VStack(spacing: 24) {
                CustomTextField(label: "Password", placeholder: "", text: $model.password, isSecure: true)
                CustomTextField(label: "Confirm Password", placeholder: "", text: $model.password, isSecure: true)
                HStack(alignment: .top) {
                    Button {
                        model.acceptRules.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.cBlue, lineWidth: 2)
                                .frame(maxWidth: 18, maxHeight: 18)
                                
                            if model.acceptRules {
                                Circle()
                                    .frame(maxWidth: 5)
                                    .foregroundStyle(Color.cBlue)
                                
                            }
                        }
                    }
                    Group {
                        Text("I ")
                            .font(.custom("Fredoka", size: 17)).foregroundStyle(Color.dGray) +
                        Text("have made myself acquainted with the Rules")
                            .font(.custom("Fredoka", size: 17)).foregroundStyle(Color.cBlue) +
                        Text(" and accept all its provisions,")
                            .font(.custom("Fredoka", size: 17)).foregroundStyle(Color.dGray)
                    }
                    .onTapGesture {
                       
                    }

                }
            }
            .padding(.horizontal, 24)
            
            Button {
                model.signUp()
            } label: {
                Text("Singup")
            }
            .buttonStyle(MainButtonStyle())
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .padding(.top, 73)
            
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
    SignUpSecondView(model: SignUpViewModel())
}
