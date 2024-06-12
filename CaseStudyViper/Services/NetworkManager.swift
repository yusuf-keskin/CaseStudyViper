//
//  NetworkManager.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

enum NetworkingError : Error, LocalizedError {
    case downloadError(receivedError: Error?)
    case urlError(receivedError: Error?)
    case lastPage
    case responseError
    
    var errorDescription: String {
        switch self {
            case .downloadError(let receivedError):
                return "Download data from api has failed, error: \(String(describing: receivedError?.localizedDescription))"
            case .urlError(let receivedError):
                return "Creating url from string file has failed, error: \(String(describing: receivedError?.localizedDescription))"
            case .lastPage:
                return "No more data in the endpoint to load"
            case .responseError:
                return "URL request returned unecpected status code"
        }
    }
}

protocol NetworkManagerProtocol {
    func download<T:Decodable>(type: T.Type, from url: URL) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol{
    
    var session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func download<T:Decodable>(type: T.Type, from url: URL) async throws -> T {

        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 299 else {
                throw NetworkingError.responseError
            }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            
            return decodedData
            
        } catch let error {
            print(error)
            throw error
        }
    }
}

