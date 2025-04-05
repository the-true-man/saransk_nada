//
//  CustomPageIndicators.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

struct CustomPageIndicators: View {
    @Binding var currentPage: Int
    var totalPages: Int
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages) { index in
                Circle()
                    .frame(maxWidth: 8, maxHeight: 8)
                    .foregroundColor(index == currentPage ? .cOrange : .dark.opacity(0.2))
            }
        }
    }
}
