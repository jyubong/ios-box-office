//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by jyubong on 12/1/23.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    private let api = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105"
    
    func test_fetchData_success() async throws {
        // given
        let url = try XCTUnwrap(URL(string: api))
        let data = try XCTUnwrap(TestMovieJsonData.json.data(using: .utf8))
        let response = try XCTUnwrap(HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil))
        let dummy = DummyData(data: data, response: response)
        let stubUrlSession = StubURLSession(dummy: dummy)
        sut = NetworkManager(urlSession: stubUrlSession)
        let expectaion = try JSONDecoder().decode(Movie.self, from: data)
        
        // when
        let result = try await sut.fetchData(url: api, dataType: Movie.self)
        
        // then
        XCTAssertEqual(result, expectaion)
    }

        }
    }
}
