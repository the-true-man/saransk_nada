//
//  SupabaseService2.swift
//  saransk2025_2
//
//  Created by Евгений Михайлов on 05.04.2025.
//

import Foundation
import Alamofire

final class SupabaseService2 {
    private let baseUrl = "https://kkqpaipbgwrztahuibsa.supabase.co"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrcXBhaXBiZ3dyenRhaHVpYnNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2MDg2OTUsImV4cCI6MjA1OTE4NDY5NX0.uQPQLsAMAw85got0Gop2Gdhh3Afdg82-ZiprCQtCg0o"
    private var headers: HTTPHeaders {
        [
            "apikey": apiKey,
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]
    }
    
    func fetchData<T: Decodable>(table: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/rest/v1/\(table)?select=*") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: [T].self) { response in
                switch response.result {
                case .success(let items):
                    completion(.success(items)) 
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

/// АВТОРИЗАЦИЯЯЯ
extension SupabaseService2 {
    func signIn(email: String, password: String) async throws -> [String: Any] {
        // Формируем URL для аутентификации
        guard let url = URL(string: "\(baseUrl)/auth/v1/token?grant_type=password") else {
            throw NSError(domain: "Invalid URL", code: 0)
        }
        
        // Создаем тело запроса
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        var headers: [String: String] {
            [
                "apikey": apiKey,
                "Authorization": "Bearer \(apiKey)",
                "Content-Type": "application/json"
            ]
        }
        // Преобразуем тело в Data
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        // Настраиваем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = jsonData
        
        // Отправляем запрос
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Проверяем статус код
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "HTTP Error", code: statusCode, userInfo: try? JSONSerialization.jsonObject(with: data) as? [String: Any])
        }
        
        // Парсим ответ
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError(domain: "Invalid JSON", code: 0)
        }
        
        return json
    }
    func signUp(email: String, password: String) async throws -> [String: Any] {
        let endpoint = "\(baseUrl)/auth/v1/signup"
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "apikey")
        
        let requestBody: [String: Any] = [
            "email": email,
            "password": password,

        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw NSError(domain: "HTTP Error", code: statusCode, userInfo: try? JSONSerialization.jsonObject(with: data) as? [String: Any])
        }
        
        // Парсим ответ
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError(domain: "Invalid JSON", code: 0)
        }
        
        return json
    }
}
