//
//  MainButtonStyle.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import Foundation
import SwiftUI

struct MainButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(size: 20, weight: .medium, foreground: .cWhite)
            .frame(maxWidth: .infinity, maxHeight: 56)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(
                        .shadow(.inner(color: .white.opacity(0.4), radius:3, x: 0, y: 3))
                    )
                    .foregroundColor(Color.cBlue)
            )
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            
    }
}
