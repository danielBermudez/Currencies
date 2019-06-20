//
//  APIClient.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/19/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Alamofire

enum APIError {
    case connectionError(Error)
    case authorizationError(Error)
    case serverError(Error)
    case clientError(Error)
}

enum Response<Value> {
    case success(Value)
    case failure(APIError)
}

protocol APIClientProtocol {
    func retrieveCountries(completion: @escaping (Response<[CountryModel]>) -> Void)
}
//MArk - API Client
final class APIClient: APIClientProtocol {
   
    func retrieveCountries(completion: @escaping (Response<[CountryModel]>) -> Void) {
        Alamofire.request(APIRouter.retrieveCountries)
            .validate(statusCode:200..<300)
            .responseJSON(completionHandler: {[weak self] dataResponse in
               self?.handleJSONResponse(response: dataResponse, decodeType: [CountryModel].self, completion: completion)
            })
    }
    
    // MARK: - JSON Handling
    
    private func handleJSONResponse<Value:Decodable>(response: DataResponse<Any>, decodeType: Value.Type, completion: (Response<Value>) -> Void) {
        guard let jsonData = response.data else {
            guard let serviceError = response.error,
                let statusCode = response.response?.statusCode else { return }
            handleError(statusCode: statusCode, error: serviceError, withCompletion: completion)
            return
        }
        
        do {
//            print(String(decoding: jsonData, as: UTF8.self))
            let parsedObjects = try JSONDecoder().decode(decodeType.self, from: jsonData)
            completion(.success(parsedObjects))
        } catch let error {
            handleError(statusCode: response.response?.statusCode, error: error, withCompletion: completion)
        }
    }
    
    // MARK: - Error Handling
    
    private func handleError<Value>(statusCode: Int?, error: Error, withCompletion completion: (Response<Value>) -> Void) {
        if let statusCode = statusCode {
            switch statusCode {
            case 400..<452:
                completion(.failure(.authorizationError(error)))
            case 500..<512:
                completion(.failure(.serverError(error)))
            default:
                completion(.failure(.connectionError(error)))
            }
        }
    }
    
}
