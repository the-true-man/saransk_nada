//
//  CustomTextField.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 04.04.2025.
//

import SwiftUI

struct CustomTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    init(label: String, placeholder: String, text: Binding<String>, isSecure: Bool) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    @State var isShowPassword = false
    @FocusState var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(label)
                    .font(size: 15, weight: .regular, foreground: .darkLighter)
                    .padding(.bottom, 8)
                ZStack(alignment: .leading) {
                    if !isSecure {
                        TextField("", text: $text)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    else {
                        ZStack(alignment: .trailing) {
                            if isShowPassword {
                                TextField("", text: $text)
                                    .textFieldStyle(CustomTextFieldStyle())
                            }
                            else {
                                SecureField("", text: $text)
                                    .textFieldStyle(CustomTextFieldStyle())
                            }
                            Button {
                                isShowPassword.toggle()
                            } label: {
                                Image("eye.close")
                            }
                            .padding(.horizontal, 20)
                            
                            
                        }
                    }
                    if text.isEmpty && !isSecure {
                        Text(placeholder)
                            .font(size: 15, weight: .regular, foreground: .darkLighter.opacity(0.5))
                            .padding(.horizontal, 20)
                    }
                    else if text.isEmpty && isSecure {
                        HStack {
                            ForEach(0..<7) { index in
                                Circle()
                                    .frame(maxWidth: 6, maxHeight: 6)
                                    .foregroundColor(Color.dGray.opacity(0.5))
                            }
                        }
                        .padding(.leading, 20)
                    }
                }
                .focused($isFocused)
                .onTapGesture {
                    isFocused = true
                }
            }
            
        }
    }
}

#Preview {
    CustomTextField(label: "Email", placeholder: "Email", text: .constant(""), isSecure: true)
}
