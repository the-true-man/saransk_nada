//
//  Topbar.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 03.04.2025.
//

import SwiftUI

struct Topbar: View {
    var header: String
    var isBackable: Bool
    @Environment(\.presentationMode) var pm
    var body: some View {
        Text(header)
            .font(size: 17, weight: .medium, foreground: .cWhite)
            .frame(maxWidth: .infinity, alignment: isBackable ? .center : .leading)
            .overlay {
                if isBackable {
                    Button {
                        pm.wrappedValue.dismiss()
                    } label: {
                        Image("arrow.back")
                            .foregroundColor(.cWhite)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 24)
                }
            }
            .padding(.leading, isBackable ? 0 : 24)

            .padding(.bottom, 20)
            .padding(.top, 60)

            .background(Color.deepBlue)
    }
}

#Preview {
    Topbar(header: "Sign in", isBackable: false)
}
