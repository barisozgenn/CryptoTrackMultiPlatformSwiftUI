//
//  NetworkManager.swift
//  CryptoTrackSwiftUI
//
//  Created by Baris OZGEN on 19.09.2022.
//

import Foundation
import Combine // for : AnyPublisher and Subscribers

class NetworkManager{
    
   private enum ResponseError: LocalizedError {
        case badURL(url:URL)
        case unknown
        
        var errorDescription: String{
            switch self {
            case .badURL(url: let url): return "DEBUG: ❗ Bad Response From URL: \(url)"
            case .unknown: return "DEBUG: ⚠️ Unknown error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error>{
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private static func handleResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
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
