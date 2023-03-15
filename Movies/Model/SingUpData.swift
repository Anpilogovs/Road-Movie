//
//  SingUpData.swift
//  Movies
//
//  Created by Сергей Анпилогов on 14.03.2023.
//

import Foundation

struct SignUpData {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    
    // Сохранение данных пользователя
    static func saveUserData(firstName: String, lastName: String, email: String, password: String) {
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: "firstNameKey")
        defaults.set(lastName, forKey: "lastNameKey")
        defaults.set(email, forKey: "emailKey")
        defaults.set(password, forKey: "passwordKey")
    }
    
    // Получение данных пользователя
    static func getUserData() -> (firstName: String?, lastName: String?, email: String?, password: String?) {
        let defaults = UserDefaults.standard
        let firstName = defaults.string(forKey: "firstNameKey")
        let lastName = defaults.string(forKey: "lastNameKey")
        let email = defaults.string(forKey: "emailKey")
        let password = defaults.string(forKey: "passwordKey")
        
        return (firstName, lastName, email, password)
    }
    
    // Удаление данных пользователя
    static func clearUserData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "firstNameKey")
        defaults.removeObject(forKey: "lastNameKey")
        defaults.removeObject(forKey: "emailKey")
        defaults.removeObject(forKey: "passwordKey")
    }
}

