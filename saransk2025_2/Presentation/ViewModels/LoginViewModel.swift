//
//  LoginViewModel.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 04.04.2025.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isConnected = true
    @Published var isLoading = false
    let supabase = SupabaseService()
    let supabase2 = SupabaseService2()
    var canc: Set<AnyCancellable> = []
    init() {
        let nw = NetworkMonitor.shared
        nw.$isConnected
            .sink { [weak self] isConnected in
                self?.isConnected = isConnected
            }
            .store(in: &canc)
        getGames()
    }
    func getGames() {
        supabase2.fetchData(table: "games") { (result: Result<[Game], Error>) in
            switch result {
            case .success(let games):
                print("Fetched games: \(games)") // Выводим полученные экземпляры Game
            case .failure(let error):
                print("Error fetching games: \(error.localizedDescription)")
            }
        }
    }
    
    func login(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        supabase.signIn(email: email, password: email) { result in
            switch result {
            case .success:
                print("НОРМАЛЬНО АВТОРИЗОВАЛСЯ")
            case .failure(let error):
                print("Ошибка авторизации:", error.localizedDescription)
            }
        }
    }
    
    func login2() {
        //        supabase2.login(email: "user@example.com", password: "password123") { result in
        //            switch result {
        //            case .success(let token):
        //                print("Access token received: \(token)")
        //            case .failure(let error):
        //                print("Error during login: \(error.localizedDescription)")
        //            }
        //        }
        Task {
            isLoading = true
            do {
                let response = try await SupabaseService2().signIn(email: email, password: password)
                print("Auth response:", response)
                if let accessToken = response["access_token"] as? String {
                    print("Authenticated successfully! Token:", accessToken)
                }
            } catch {
                let error = String(describing: error)
                print("Auth error:", String(describing: error))
                if error.contains("Invalid login") {
                    print("неверный емайл или пароль")
                }
                
                
            }
            isLoading = false
        }
    }
    
}
