//
//  NewsEndpoint.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation
import Moya

enum NewsEndpoints {
    
    static private let apiKey = "test"
    
    case news(query: String?, page: Int)
}

extension NewsEndpoints: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://content.guardianapis.com")!
    }
    
    var path: String {
        return "/search"
    }
    
    var method: Moya.Method {
        switch self {
        case .news(_, _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .news(let query, let page):
            return [
                "show-fields": "thumbnail",
                "show-elements": "image",
                "page": page,
                "q": query ?? "",
                "api-key": NewsEndpoints.apiKey
            ]
        }
    }
    
    public var validationType: ValidationType {
       return .successCodes
     }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
}
