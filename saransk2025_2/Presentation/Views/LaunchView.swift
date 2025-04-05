//
//  LaunchView.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

struct LaunchView: View {
    let onCompletion: () -> Void
    @State private var isAnimating = false
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 250)
            Image("launchIcon")
                .scaleEffect(isAnimating ? 1.5 : 1.0)
                .opacity(isAnimating ? 0 : 1)
            Text("Language App")
                .font(.custom("Fredoka", size: 37))
                .fontWeight(.bold)
                .foregroundColor(Color.cWhite)
                .padding(.top, 24)
                .scaleEffect(isAnimating ? 1.5 : 1.0)
                .opacity(isAnimating ? 0 : 1)
            Spacer()
            
        }
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.deepBlue)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.spring(duration: 2)) {
                    isAnimating = true
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                onCompletion()
            }
        }
    }
}

