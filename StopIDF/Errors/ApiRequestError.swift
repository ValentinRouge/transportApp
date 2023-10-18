//
//  ApiRequestError.swift
//  Arrêt Île-de-France
//
//  Created by Valentin Rouge on 12/10/2023.
//

import Foundation

enum ApiRequestError:Error {
    case nothingReturned
    case invalidURL
    case failDecoding
    case httpError(URLResponse?)
}
