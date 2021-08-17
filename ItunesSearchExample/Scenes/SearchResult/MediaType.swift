//
//  MediaType.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

enum MediaType: String, CaseIterable {
    case all
    case music
    case movie
    case podcast

    var title: String {
        rawValue.uppercasingFirst
    }

    var navTitle: String {
        if self == .all {
            return ""
        }
        return title
    }
}
