//
//  URLSessionProtocol.swift
//  AcronymsFinder
//
//  Created by u533623 on 14/12/22.
//

import Foundation

protocol URLSessionDataTaskProtocol{
    
    func resume()
    func cancel()
}

protocol URLSessionProtocol {
    
  func dataTask(
    with request: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
  ) -> URLSessionDataTask
}
