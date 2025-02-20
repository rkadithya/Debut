//
//  GitHubViewModel.swift
//  Debut
//
//  Created by RK Adithya on 20/02/25.
//

import Foundation
import Combine

class GitHubViewModel : ObservableObject {
    @Published var gitUsers : [GitHubModel] = []
    var cancellable = Set<AnyCancellable>()
    let apiService : ApiServiceProtocol
    
    init(ApiService : ApiServiceProtocol){
        self.apiService = ApiService
    }
    
    
    func getUsers(){
        apiService.getUsers()
            .sink(receiveCompletion: { completion in
                
                switch completion{
                case .failure(let error) :
                    print(error.localizedDescription)
                case .finished :
                    print("Success")
                    break
                }
            }, receiveValue: { [weak self] users in
                self?.gitUsers = users
            })
            .store(in: &cancellable)
    }
}
