//
//  NotConnectionView.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import SwiftUI

struct NotConnectionView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 92)
                .foregroundStyle(Color.deepBlue)
            Spacer()
            Text("🫩")
                .font(size: 150, weight: .medium, foreground: .deepBlue)
            Text("No internet connection ")
                .font(size: 30, weight: .medium, foreground: .deepBlue)
Spacer()
            Button {
                
            } label: {
                Text("Check again")
            }
            .buttonStyle(MainButtonStyle())

        }
    }
}

#Preview {
    NotConnectionView()
}
