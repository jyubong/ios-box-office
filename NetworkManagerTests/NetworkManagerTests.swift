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
        let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20220105")!
        let data = TestMovieJsonData.json.data(using: .utf8)!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubURLSession = StubURLSession(dummy: dummy)
        
        sut = .init(urlSession: stubURLSession)
        
        var result: [DailyBoxOfficeList]?
        
        sut.fetchDailyBoxOffice(at: "20220105") { dailyBoxOfficeList, error  in
            result = dailyBoxOfficeList
        }
        
        let expectation: [DailyBoxOfficeList]? = try? JSONDecoder().decode(Movie.self, from: data).boxOfficeResult.dailyBoxOfficeList
        
        XCTAssertEqual(result, expectation)
        XCTAssertNotNil(result)
        XCTAssertNotNil(expectation)
    }
}
