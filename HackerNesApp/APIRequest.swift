//
//  APIRequest.swift
//  HackerNesApp
//
//  Created by John Hur on 2022/04/19.
//

import Foundation

class APIRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func perform<T: Decodable>(with completion: @escaping (T?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            completion(try? decoder.decode(T.self, from: data))
        }
        task.resume()
    }
    
    
    
}