//
//  NetworkCombineManager.swift
//  CryptoTrackSwiftUIMultiPlatform
//
//  Created by Baris OZGEN on 4.10.2022.
//

import Foundation
import Combine

class NetworkCombineManager {
    
    enum ResponseError: Error, LocalizedError {
        case unknown
        case badURL(reason: String)
        case parserError(reason: String)
        
        var errorDescription: String? {
            switch self {
            case .unknown: return "DEBUG: ⚠️ Unknown error"
            case .badURL(let url): return "DEBUG: ❗ Bad Response From URL: \(url)"
            case .parserError(let reason): return "DEBUG: ❗ Parse Error ❗ : \(reason)"
                
            }
        }
    }
    
    
    private static func fetch(url: URL) -> AnyPublisher<Data, ResponseError> {
        let request = URLRequest(url: url)
        
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw ResponseError.unknown
                }
                return data
            }
            .mapError { error in
                if let error = error as? ResponseError {
                    return error
                } else {
                    return ResponseError.badURL(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    static func download<T: Decodable>(url: URL) -> AnyPublisher<T, ResponseError> {
        fetch(url: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? DecodingError {
                    var errorToReport = error.localizedDescription
                    switch error {
                    case .dataCorrupted(let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) - (\(details))"
                    case .keyNotFound(let key, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
                    case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                        let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                        errorToReport = "\(context.debugDescription) (type: \(type), \n\(details),\n \(context.codingPath)"
                           
                    @unknown default:
                        break
                    }
                    return ResponseError.parserError(reason: errorToReport)
                }  else {
                    return ResponseError.badURL(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished : break
        case .failure(let error) : print("❗ \(error.localizedDescription)")
            
        }
    }
}


