//
//  AuthError.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 06.04.2025.
//

import Foundation


enum AuthError: Error {
    case invalidCredentials
    case validationFailed(message: String)
    case tooManyRequests
    case serverError
    case unknownError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "Неверный email или пароль"
        case .validationFailed(let msg):
            return "Ошибка ввода: \(msg)"
        case .tooManyRequests:
            return "Слишком много попыток. Попробуйте позже"
        case .serverError:
            return "Ошибка сервера"
        case .unknownError(let msg):
            return "Неизвестная ошибка: \(msg)"
        }
    }
}
