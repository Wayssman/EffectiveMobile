//
//  API.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import Foundation

typealias DataTaskResult = Result<Data?, APIError>
typealias APIResult<Model> = Result<Model, APIError>

enum APIError: Error {
    case noUrl
    case transportError(Error)
    case serverError(Int)
    case nilResponse
    case mimeError
    case noDataError
    case jsonError(Error)
    case parseError(Error)
}

enum HTTPMethod: String {
    case get = "GET"
}
