//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, FetchError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(T.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            completion(movie, nil)
        }.resume()
    }
}
