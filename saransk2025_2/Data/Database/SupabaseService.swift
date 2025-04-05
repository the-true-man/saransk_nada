import Alamofire
import Foundation

final class SupabaseService {
    
    private let baseUrl = "https://kkqpaipbgwrztahuibsa.supabase.co"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrcXBhaXBiZ3dyenRhaHVpYnNhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDM2MDg2OTUsImV4cCI6MjA1OTE4NDY5NX0.uQPQLsAMAw85got0Gop2Gdhh3Afdg82-ZiprCQtCg0o"
    private var headers: HTTPHeaders {
        [
            "apikey": apiKey,
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/json"
        ]
    }
    
    // MARK: - Fetch All Data
    func fetchAll<T: Decodable>(
        from table: String,
        completion: @escaping (Result<[T], AFError>) -> Void
    ) {
        let endpoint = "\(baseUrl)/rest/v1/\(table)?select=*"
        AF.request(endpoint, headers: headers)
            .validate()
            .responseDecodable(of: [T].self) { response in
                completion(response.result)
                AF.session.finishTasksAndInvalidate()
            }
        
    }
    
    // MARK: - Fetch with Filter
    func fetch<T: Decodable>(
        from table: String,
        parameters: Parameters,
        completion: @escaping (Result<[T], AFError>) -> Void
    ) {
        let endpoint = "\(baseUrl)/rest/v1/\(table)"
        
        AF.request(endpoint, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: [T].self) { response in
                completion(response.result)
            }
    }
    
    // MARK: - Complex Query
    func query<T: Decodable>(
        from table: String,
        select: String = "*",
        range: (from: Int, to: Int)? = nil,
        filters: [String: Any] = [:],
        order: [String: String] = [:],
        completion: @escaping (Result<[T], AFError>) -> Void
    ) {
        var endpoint = "\(baseUrl)/rest/v1/\(table)?select=\(select)"
        
        // Add filters
        filters.forEach { key, value in
            endpoint += "&\(key)=\(value)"
        }
        
        // Add sorting
        order.forEach { key, value in
            endpoint += "&order=\(key).\(value)"
        }
        
        var headers = self.headers
        
        // Add range header if needed
        if let range = range {
            headers["Range"] = "\(range.from)-\(range.to)"
        }
        
        AF.request(endpoint, headers: headers)
            .validate()
            .responseDecodable(of: [T].self) { response in
                completion(response.result)
            }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "\(baseUrl)/auth/v1/token")!
        var headers: [String: String] {
            [
                "apikey": apiKey,
                "Authorization": "Bearer $apiKey)",
                "Content-Type": "application/json"
            ]
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "grant_type": "password"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            // Обработка ответа
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response: \(jsonResponse)")
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}

struct AuthResponse: Decodable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case user
    }
}

struct User: Decodable {
    let id: UUID
    let email: String
    let createdAt: Date
    // Добавьте другие необходимые поля
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case createdAt = "created_at"
    }
}
