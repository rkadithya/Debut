//
//  GitHubModel.swift
//  Debut
//
//  Created by RK Adithya on 20/02/25.
//

import Foundation
//"login": "defunkt",
//"id": 2,
//"node_id": "MDQ6VXNlcjI=",
//"avatar_url": "https://avatars.githubusercontent.com/u/2?v=4",
//"gravatar_id": "",
//"url": "https://api.github.com/users/defunkt",
//"html_url": "https://github.com/defunkt",

struct GitHubModel : Codable, Identifiable{
    let id : Int
    let login : String
    let avatar_url : String
    let html_url : String
}
