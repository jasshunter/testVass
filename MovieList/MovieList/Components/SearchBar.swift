//
//  SearchBar.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var search: String
    @Binding var showFilters: Bool
    var callback: (String) -> Void = { _ in }
    
    var body: some View {
        
        HStack {
            
            HStack {
                
                Image(systemName: "magnifyingglass")
                TextField(LocalizedStringKey("Search..."), text: $search)
                    .onChange(of: self.search) { newValue in
                        callback(newValue)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                
                showFilters.toggle()
                
            }) {
                
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    .imageScale(.large)
            }
            
        }.padding()
            .background(Color.white)
    }
}

#Preview {
    SearchBar(search: .constant(""), showFilters: .constant(false), callback: { search in })
}
