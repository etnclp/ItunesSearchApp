//
//  NetworkingError.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 13.04.2021.
//

import Foundation

/// Error type to be used in Networking module
public enum NetworkingError: Error {

    /// Indicates that there has been a connection error to the server
    case connectionError(HTTPError)

    /// Indicates that parsing is not possible with the current data and
    /// given type to parse into.
    case decodingFailed(DecodingError)
    
    /// `ParameterEncoding` threw an error during the encoding process.
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)

    /// In case an error occures which is not identified
    case undefined

    public var description: String? {
        var message: String?
        switch self {
        case .connectionError(let error):
            message = error.errorDescription
        case .decodingFailed(let error):
            message = error.errorDescription
        case .parameterEncodingFailed(let reason):
            message = reason.localizedDescription
        case .undefined:
            message = "undefined"
        }
        return message
    }
    
    public enum ParameterEncodingFailureReason {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        
        case jsonEncodingFailed(error: Error)
        
        /// Custom parameter encoding failed due to the associated `Error`.
        case customEncodingFailed(error: Error)
        
        var localizedDescription: String {
            switch self {
            case .missingURL:
                return "URL request to encode was missing a URL"
            case let .jsonEncodingFailed(error):
                return "JSON could not be encoded because of error:\n\(error.localizedDescription)"
            case let .customEncodingFailed(error):
                return "Custom parameter encoder failed with error: \(error.localizedDescription)"
            }
        }
    }

}
