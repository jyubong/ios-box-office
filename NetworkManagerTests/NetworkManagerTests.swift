//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by jyubong on 11/30/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!

    func test_fetchDailyBoxOffice() {
        // given
        let api = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"
        
        guard let url = URL(string: api) else {
            XCTFail()
            return
        }
        
        guard let data = TestMovieJsonData.json.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubURLSession = StubURLSession(dummy: dummy)
        
        sut = .init(urlSession: stubURLSession)
        
        let expectation: Movie? = try? JSONDecoder().decode(Movie.self, from: data)
        var result: Movie?
        
        // when
        sut.fetchData<Movie>(url: api) { movie, error  in
            result = movie
        }
        
        // then
        XCTAssertEqual(result, expectation)
        XCTAssertNotNil(result)
        XCTAssertNotNil(expectation)
    }
}
