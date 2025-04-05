//
//  SignUpViewModel.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import Foundation
import SwiftUI

final class SignUpViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var acceptRules: Bool = false
}
