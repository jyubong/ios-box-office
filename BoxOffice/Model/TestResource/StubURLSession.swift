//
//  StubURLSession.swift
//  BoxOffice
//
//  Created by jyubong, Kiseok on 12/1/23.
//

import Foundation

struct DummyData {
    let data: Data
    let response: URLResponse
}

class StubURLSession: URLSessionProtocol {
    var dummyData: DummyData

    init(dummy: DummyData) {
        self.dummyData = dummy
    }
    
    func data(from url: URL, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        return (dummyData.data, dummyData.response)
    }
}
