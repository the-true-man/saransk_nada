//
//  CustomTextFieldStyle.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 04.04.2025.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 20)
            .background(Color.dark.opacity(0.05))
            .cornerRadius(16)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(size: 15, weight: .regular, foreground: .dark)
    }
}
