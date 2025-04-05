//
//  SelectLanguageView.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

struct SelectLanguageView: View {
    @State private var selectedLanguageIndex = 0
    @State private var isNavigateToLogin = false
    private let languages: [String : String] = [
        "ru" : "Russian",
        "en" : "English",
        "zh" : "Chinese",
        "es" : "Spanish",
        "kk" : "Kazakh"
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Topbar(header: "Language select", isBackable: false)
                Text("What is your Mother language?")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.bottom, 4)
                
                ForEach(Array(languages.keys.enumerated()), id: \.element) { index, key in
                    Button {
                        selectedLanguageIndex = index
                    } label: {
                        Text(languages[key] ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .padding(.horizontal, 15)
                            .background(index == selectedLanguageIndex ? .cOrange : .lCream)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal, 24)
                    }
                }
                Spacer()
                Button {
                    let selectedCode = Array(languages.keys)[selectedLanguageIndex]
                    UserDefaults.standard.set(selectedCode, forKey: "selectedLanguage")
                    isNavigateToLogin = true
                } label: {
                    Text("Choose")
                    
                }
                .buttonStyle(MainButtonStyle())
                .padding(.bottom, 26)
                .padding(.horizontal, 24)
            }
            .background(Color.cWhite)
            .ignoresSafeArea(.all)
            .navigationBarBackButtonHidden()
            .onAppear {
                let systemLanguage = String(NSLocale.preferredLanguages.first?.split(separator: "-").first ?? "en")
                print(UserDefaults.standard.string(forKey: "selectedLanguage") ?? "not set")
            }
            .navigationDestination(isPresented: $isNavigateToLogin) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    SelectLanguageView()
}
