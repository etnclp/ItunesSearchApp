//
//  SearchRequest.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct SearchRequest: ITunesSearchAPI {

    typealias Response = BaseResponse<[SearchResult]>

    var path: String = "/search"
    var method: HTTPMethod = .get
    var parameters: [String : Any]?

    init(query: String, media: String, offset: Int) {
        parameters = [
            "term": query,
            "media": media,
            "limit": 10,
            "offset": offset
        ]
    }

}
