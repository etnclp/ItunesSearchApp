//
//  SearchResult.swift
//  ItunesSearchExample
//
//  Created by Erdi Tunçalp on 13.08.2021.
//  Copyright © 2021 Erdi Tunçalp. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var kind: Kind?
    var artistID, collectionID, trackID: Int?
    var artistName: String?
    var collectionName, trackName, collectionCensoredName, trackCensoredName: String?
    var artistViewURL, collectionViewURL, trackViewURL: String?
    var previewURL: String?
    var artworkUrl30, artworkUrl60, artworkUrl100: String?
    var collectionPrice, trackPrice: Double?
    var releaseDate: String?
    var collectionExplicitness, trackExplicitness: Explicitness?
    var discCount, discNumber, trackCount, trackNumber: Int?
    var trackTimeMillis: Int?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var isStreamable: Bool?
    var collectionArtistName: String?
    var collectionArtistID: Int?
    var longDescription: String?
    var contentAdvisoryRating: String?
    var trackRentalPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName
        case collectionArtistID, longDescription, contentAdvisoryRating, trackRentalPrice
    }
}

// MARK: - Explicitness

enum Explicitness: String, Codable {
    case cleaned
    case explicit
    case notExplicit
}

// MARK: - Kind

enum Kind: String, Codable {
    case book, album
    case coachedAudio = "coached-audio"
    case featureMovie = "feature-movie"
    case interactiveBooklet = "interactive-booklet"
    case musicVideo = "music-video"
    case pdf, podcast
    case podcastEpisode = "podcast-episode"
    case softwarePackage = "software-package"
    case song
    case tvEpisode = "tv-episode"
    case artist
    
    var title: String {
        switch self {
        case .book: return "Book"
        case .album: return "Album"
        case .featureMovie: return "Movie"
        case .podcast: return "Podcast"
        case .podcastEpisode: return "Podcast Episode"
        case .song: return "Song"
        case .tvEpisode: return "TV Episode"
        default: return "Other"
        }
    }
}
