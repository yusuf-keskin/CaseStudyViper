//
//  NetworkManager.swift
//  CaseStudyViper
//
//  Created by YUSUF KESKİN on 6.06.2024.
//

import Foundation

class NetworkManager {
    static func download<T:Decodable>(type: T.Type, from url: URL) async throws -> T {
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(from: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(type, from: data)
            return decodedData
            
        } catch let error {
            print(error)
            throw error
        }
    }
}

