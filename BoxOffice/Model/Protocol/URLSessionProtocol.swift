//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by jyubong on 11/30/23.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}
