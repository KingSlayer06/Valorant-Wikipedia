//
//  NetworkError.swift
//  Valorant-Stats
//
//  Created by Himanshu Sherkar on 17/11/26.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noInternetConnection
    case timeout
    case server(statusCode: Int)
    case emptyResponse
    case decodingFailed(underlying: Error)
    case cancelled
    case unknown(underlying: Error)
}

extension NetworkError {
    var isRetryable: Bool {
        switch self {
        case .noInternetConnection, .timeout:
            return true
        case .server(let statusCode):
            return statusCode >= 500
        case .unknown:
            return true
        case .invalidURL, .emptyResponse, .decodingFailed, .cancelled:
            return false
        }
    }
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request could not be created."
        case .noInternetConnection:
            return "You appear to be offline. Check your internet connection and try again."
        case .timeout:
            return "The server took too long to respond. Please try again."
        case .server(let statusCode):
            return "The server returned an error (\(statusCode)). Please try again later."
        case .emptyResponse:
            return "The server returned no data."
        case .decodingFailed:
            return "The data received from the server was in an unexpected format."
        case .cancelled:
            return "The request was cancelled."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}

extension NetworkError {
    init(_ error: Error) {
        if let networkError = error as? NetworkError {
            self = networkError
            return
        }

        if error is CancellationError {
            self = .cancelled
            return
        }

        if let urlError = error as? URLError {
            self = NetworkError(urlError: urlError)
            return
        }

        guard let afError = error.asAFError else {
            self = .unknown(underlying: error)
            return
        }

        switch afError {
        case .explicitlyCancelled:
            self = .cancelled

        case .invalidURL:
            self = .invalidURL

        case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
            self = .server(statusCode: code)

        case .responseSerializationFailed(reason: .inputDataNilOrZeroLength):
            self = .emptyResponse

        case .responseSerializationFailed(reason: .decodingFailed(let decodingError)):
            self = .decodingFailed(underlying: decodingError)

        case .sessionTaskFailed(let underlying):
            if let urlError = underlying as? URLError {
                self = NetworkError(urlError: urlError)
            } else {
                self = .unknown(underlying: underlying)
            }

        default:
            self = .unknown(underlying: afError)
        }
    }

    private init(urlError: URLError) {
        switch urlError.code {
        case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed,
             .internationalRoamingOff, .cannotFindHost, .cannotConnectToHost, .dnsLookupFailed:
            self = .noInternetConnection
        case .timedOut:
            self = .timeout
        case .cancelled:
            self = .cancelled
        case .badURL, .unsupportedURL:
            self = .invalidURL
        default:
            self = .unknown(underlying: urlError)
        }
    }
}
