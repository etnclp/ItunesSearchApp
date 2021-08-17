//
//  BaseResponse.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    var resultCount: Int?
    var results: T?
}
