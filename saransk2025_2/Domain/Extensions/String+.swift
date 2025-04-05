//
//  String+.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import Foundation


extension String {
    func validateEmail() -> Bool {
        let emailRegEx = "[0-9a-z._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}"
        
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
    
    func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[\\s!@#$%^&*()_+{}\\[\\]:;<>,.?~\\-]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
}
