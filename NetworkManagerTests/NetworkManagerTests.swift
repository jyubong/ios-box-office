//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Kiseok, jyubong
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    private let api = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"

    func test_fetchData_success() {
        // given
        let promise = expectation(description: "")
        
        guard let url = URL(string: api) else {
            XCTFail()
            return
        }
        
        guard let data = TestMovieJsonData.json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        TestURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode:200, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        sut = .init(urlSession: URLSession(configuration: configuration))
        
        let expectation: Movie? = try? JSONDecoder().decode(Movie.self, from: data)
        var result: Movie?
        
        // when
        sut.fetchData(url: api, dataType: Movie.self) { movie, error  in
            result = movie
            //then
            XCTAssertEqual(result, expectation)
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_fetchData_resoponse_Failure() {
        // given
        let promise = expectation(description: "")
        
        guard let url = URL(string: api) else {
            XCTFail()
            return
        }
        
        guard let data = TestMovieJsonData.json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        TestURLProtocol.loadingHandler = { request in
            let response = HTTPURLResponse(url: url, statusCode:404, httpVersion: nil, headerFields: nil)
            return (data, response, nil)
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self]
        
        sut = .init(urlSession: URLSession(configuration: configuration))
        
        let expectation = FetchError.invalidResponse
        
        // when
        sut.fetchData(url: api, dataType: Movie.self) { movie, error in
            guard let result = error as? FetchError else {
                XCTFail()
                return
            }
            
            //then
            XCTAssertNil(movie)
            XCTAssertEqual(result, expectation)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
}
