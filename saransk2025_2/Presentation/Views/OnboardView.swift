//
//  OnboardVIew.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

struct OnboardView: View {
    private let title = ["Confidence in your words",
                         "Take your time to learn",
                         "The lessons you need to learn"]
    private let description = ["With conversation-based learning, you'll be talking from lesson one",
                               "Develop a habit of learning and make it a part of your daily routine",
                               "Using a variety of learning styles to learn and retain"]
    private let textOnButton = ["Next", "More", "Choose a language"]
    @State private var currentOnboardIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("onb\(currentOnboardIndex+1)")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, currentOnboardIndex == 0 ? 68 : 80)
                Spacer()
                CustomPageIndicators(currentPage: $currentOnboardIndex, totalPages: 3)
                    .padding(.bottom, 40)
                Text(title[currentOnboardIndex])
                    .font(size: 22, weight: .medium, foreground: .dark)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                Text(description[currentOnboardIndex])
                    .font(size: 15, weight: .regular, foreground: .dark.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 70)
                    .padding(.bottom, 50)
                if currentOnboardIndex < 2 {
                    Button {
                        nextOnboard()
                    } label: {
                        Text(textOnButton[currentOnboardIndex])
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 24)
                }
                else {
                    NavigationLink {
                        SelectLanguageView()
                    } label: {
                        Text(textOnButton[currentOnboardIndex])
                    }
                    .buttonStyle(MainButtonStyle())
                    .padding(.horizontal, 24)
                }
                NavigationLink(destination: {
                    SelectLanguageView()
                }, label: {
                    Text("Skip onboarding")
                        .font(size: 15, weight: .regular, foreground: .dark)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                })
                .padding(.horizontal, 24)


            }
        }
        .animation(.easeInOut(duration: 0.7), value: currentOnboardIndex)
    }
    
    func nextOnboard(_ value: Int = 1) {
        if currentOnboardIndex == 2 {
            return
        }
        
        currentOnboardIndex += value
    }
}

#Preview {
    OnboardView()
}
