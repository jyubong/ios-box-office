//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let key = "3d65ed918572e0c8dc412bb3bf722f49"
    
    private init() { }
    
    func fetchDailyBoxOffice(at date: String) async throws -> [DailyBoxOfficeList] {
        let api = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
        
        guard let url = URL(string: api) else {
            throw FetchError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw FetchError.invalidResponse
        }
        
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        
        return movie.boxOfficeResult.dailyBoxOfficeList
    }
    
    func fetchMovieDetail(code: String) async throws -> MovieInfo {
        let api = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)"
        
        guard let url = URL(string: api) else {
            throw FetchError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw FetchError.invalidResponse
        }
        
        let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
        
        return movieDetail.movieInfoResult.movieInfo
    }
}
