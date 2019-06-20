//
//  APIRouter.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/19/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case retrieveCountries
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .retrieveCountries:
            return .get
        }
    }
    
    // MARK: - Path
    private var fullURL: String {
        switch self {
        case .retrieveCountries:
            return "https://restcountries.eu/rest/v2/all"
        }
    }
    
    //MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .retrieveCountries:
            return [:]
        }
    }
    //MARK: - Headers
    private var headers: [String: String] {
        switch self {
        case .retrieveCountries:
            return [:]
        }
    }
    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try fullURL.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        //HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        //CommonHeaders
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        //Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error:error))
            }
        }
        return urlRequest
    }
    
    
}
