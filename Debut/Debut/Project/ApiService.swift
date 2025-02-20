//
//  ApiService.swift
//  Debut
//
//  Created by RK Adithya on 20/02/25.
//

import Foundation
import Combine

protocol ApiServiceProtocol {
    
    func getUsers() -> AnyPublisher<[GitHubModel],Error>
}


class ApiService : ApiServiceProtocol{
    
    static let shared = ApiService()
    
    func getUsers() -> AnyPublisher<[GitHubModel], any Error> {
        
        guard let url = URL(string: "https://api.github.com/users") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [GitHubModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
  
}
