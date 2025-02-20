//
//  GitHubDetailView.swift
//  Debut
//
//  Created by RK Adithya on 20/02/25.
//

import Foundation
import SwiftUI
import WebKit


struct DetailView : View{
    let url : String
    var body: some View{
        if let validUrl = URL(string: url){
            WebView(url: validUrl)

        }else{
            Text("Invalid Url")
        }
    }
    
}


struct WebView : UIViewRepresentable{

    let url : URL
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        
        
    }
    
    
}
