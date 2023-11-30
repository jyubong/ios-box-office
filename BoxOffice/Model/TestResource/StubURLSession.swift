//
//  StubURLSession.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil

    func completion() {
        completionHandler?(data, response, error)
    }
}

class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?

    init(dummy: DummyData?, completionHandler: DataTaskCompletionHandler?) {
        self.dummyData = dummy
        self.dummyData?.completionHandler = completionHandler
    }

    override func resume() {
        dummyData?.completion()
    }
}

class StubURLSession: URLSessionProtocol {
    var dummyData: DummyData?

    init(dummy: DummyData) {
        self.dummyData = dummy
    }

    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return StubURLSessionDataTask(dummy: dummyData, completionHandler: completionHandler)
    }
}
