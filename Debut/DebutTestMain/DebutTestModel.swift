//
//  DebutTest.swift
//  DebutUITests
//
//  Created by RK Adithya on 20/02/25.
//

import Foundation
import XCTest
import Combine
@testable import Debut

class DebutTestModel : XCTestCase{
    
    var viewModel :  GitHubViewModel!
    var mockApiService : MockApiService!
    var cancellable : Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        viewModel = GitHubViewModel(ApiService: mockApiService)
        cancellable = []
    }
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        mockApiService = nil
        cancellable = nil
    }
    
    func fetchUsers_Success(){
        
            let mockUsers = [
                
                GitHubModel(id: 1, login: "Adithya", avatar_url: "www.url.com", html_url: "www.url.com"),
                GitHubModel(id: 2, login: "Krishna", avatar_url: "www.url.com", html_url: "www.url.com"),
              
            ]
        
        mockApiService.users = mockUsers
        
        let exceptions = XCTestExpectation(description: "Fetch Users")
        viewModel.$gitUsers
            .dropFirst()
            .sink(receiveValue: { users in
                XCTAssertEqual(users.count, mockUsers.count)
                XCTAssertEqual(users.first?.login, "Adithya")
                exceptions.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel.getUsers()
        
        wait(for: [exceptions], timeout: 2.0)
        
        
        
    }
    
    func fetchUsers_failure(){
        mockApiService.shouldReturnError = true
        let exceptions = XCTestExpectation(description: "Fetch Failure")
        viewModel.$gitUsers
            .dropFirst()
            .sink(receiveValue: { users in
                XCTAssertEqual(users.count, 0)
                exceptions.fulfill()
            })
            .store(in: &cancellable)
        viewModel.getUsers()
        
        wait(for: [exceptions], timeout: 2.0)
    }
}

class MockApiService : ApiServiceProtocol{
    
    var shouldReturnError = false
    var users : [GitHubModel] = []

    func getUsers() -> AnyPublisher<[Debut.GitHubModel], any Error> {
        
        if shouldReturnError {
            
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            
        }else{
            return Just(users)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    
}
