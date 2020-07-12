//
//  APIService.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation
import Moya

class APIService {
    // I'm using a singleton for the sake of demonstration and other lies I tell myself
    static let shared = APIService()
    
    private init() {}
    
    private let provider = MoyaProvider<NewsEndpoints>()
    
    func getNews(at page: Int, for query: String?, completion: @escaping (Result<News, Error>) -> ()) {
        provider.request(.news(query: query, page: page)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(News.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
