//
//  ContentView.swift
//  ConexaProjectInterview
//
//  Created by Juan Bazan Carrizo on 24/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Group {
                PostView()
                    .tabItem {
                        Image(systemName: "list.bullet.below.rectangle")
                        Text("Post")
                    }
    
                UserView()
                    .tabItem {
                        Image(systemName: "map")
                        Text("Users")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
            
        } //: TabView
        .ignoresSafeArea(edges: .top)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
