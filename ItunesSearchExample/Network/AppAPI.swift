//
//  AppAPI.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Moya

enum AppAPI {
    case search(term: String, media: String)
}

extension AppAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .search: return "/search"
        }
    }
    
    var method: Method {
        switch self {
        case .search: return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        if method == .post {
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        } else {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any] {
        switch self {
        case .search(let term, let media):
            return [
                "term": term,
                "media": media,
                "limit": 100,
                "country": "tr"
            ]
        }
    }
    
    
}
