//
//  ContentView.swift
//  Debut
//
//  Created by RK Adithya on 20/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GitHubViewModel(ApiService: ApiService.shared)
    
    var body: some View {
        NavigationStack {
            VStack{
            List(viewModel.gitUsers) { gitUsers in
                NavigationLink(destination: DetailView(url: gitUsers.html_url)){
                    VStack{
                    HStack{
                        
                        AsyncImage(url: URL(string: gitUsers.avatar_url)){ image in
                            image.image?.resizable()
                            
                        }.frame(width: 50, height:  50)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        Text(gitUsers.login)
                        
                        
                        
                    }
                }}
            }
            
        }}
        .padding()
        .onAppear(perform: viewModel.getUsers)
    }
}

#Preview {
    ContentView()
}
