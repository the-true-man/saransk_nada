//
//  View+.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import Foundation
import SwiftUI

extension View {
    func font(size: CGFloat, weight: Font.Weight, foreground: Color) -> some View {
        /// Задает основной шрифт с разными вариантомы стиля и цветом
        self.font(.custom("Fredoka", size: size)).fontWeight(weight).foregroundColor(foreground)
    }
}
