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
                    .foregroundColor(Color.gray)
                    .imageScale(.small)
                
                TextField(LocalizedStringKey("Search..."), text: $search)
                    .disableAutocorrection(true)
                    .onChange(of: self.search) { newValue in
                        callback(newValue)
                    }
                
                if !search.isEmpty {
                    
                    Button(action: {
                        
                        search = ""
                    }) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(Color.gray)
                            .imageScale(.small)
                    }
                }
                    
            }.padding(4)
            .overlay(
            
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.8), lineWidth: 1)
            )
            
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
