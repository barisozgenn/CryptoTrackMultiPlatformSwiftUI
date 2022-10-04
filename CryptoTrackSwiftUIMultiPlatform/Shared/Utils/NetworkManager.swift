//
//  NetworkManager.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 19.09.2022.
//

import Foundation
import Combine // for : AnyPublisher and Subscribers

class NetworkManager{
    
    enum ResponseError: LocalizedError {
        case badURL(url:URL)
        case unknown
        case parserError(reason: String)
       
        var errorDescription: String{
            switch self {
            case .badURL(url: let url): return "DEBUG: ❗ Bad Response From URL: \(url)"
            case .parserError(let reason): return "DEBUG: ❗ Parse Error : \(reason)"
            case .unknown: return "DEBUG: ⚠️ Unknown error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleResponse(output: $0, url: url)})
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
                        errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
                    @unknown default:
                        break
                    }
                    return ResponseError.parserError(reason: errorToReport)
                }  else {
                    return ResponseError.badURL(url: url)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
   
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200, response.statusCode <= 300
        else {
            throw ResponseError.badURL(url: url)
        }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
        case .finished : break
        case .failure(let error) : print("DEBUG: ❗ \(error.localizedDescription)")
            
        }
    }
    
   
}


 
 
 
