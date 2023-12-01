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
    
    func fetchData<T: Decodable>(url: String, dataType: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw FetchError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw FetchError.invalidResponse
        }
        
        let movie = try JSONDecoder().decode(dataType, from: data)
        
        return movie
    }
}
