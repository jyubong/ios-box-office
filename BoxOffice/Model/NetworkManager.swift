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
    var urlSession = URLSession.shared
    
    private init() { }
    
    func fetchDailyBoxOffice(at date: String, completion: @escaping ([DailyBoxOfficeList]?, Error?) -> Void) {
        let api = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(date)"
        
        guard let url = URL(string: api) else {
            completion(nil, FetchError.invalidURL)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            let dailyBoxOfficeList = movie.boxOfficeResult.dailyBoxOfficeList
            
            completion(dailyBoxOfficeList, nil)
        }.resume()
    }
    
    func fetchMovieDetail(code: String, completion: @escaping (MovieInfo?, Error?) -> Void) {
        let api = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(code)"
        
        guard let url = URL(string: api) else {
            completion(nil, FetchError.invalidURL)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                completion(nil, FetchError.invalidResponse)
                return
            }
            
            guard let data = data, let movie = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                completion(nil, FetchError.invalidData)
                return
            }
            
            let movieInfo = movie.movieInfoResult.movieInfo
            
            completion(movieInfo, nil)
        }.resume()
    }
}
