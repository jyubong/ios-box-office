//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by jyubong, Kiseok on 12/1/23.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
