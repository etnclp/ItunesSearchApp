//
//  ITunesSearchAPI.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

protocol ITunesSearchAPI: Endpoint {}

extension ITunesSearchAPI {

    var api: API {
        return API(baseURL: BaseURL(scheme: "https", host: "itunes.apple.com"))
    }

    var defaultHeaders: [String: String] {
        let customHeaders: [String: String] = ["Content-Type": contentType.rawValue]
        return HeaderBuilder(with: self).build(customHeaders: customHeaders)
    }

}
