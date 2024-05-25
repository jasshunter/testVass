//
//  HomeMovies.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct HomeMovies: View {
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @StateObject var viewModel = MovieViewModel()
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 156))
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            PickerView()
            
            TabView(selection: $viewModel.typeSelect) {
                
                ScrollPopularMovies()
                    .tag(MovieType.popular)
                ScrollTopRatedMovies()
                    .tag(MovieType.topRated)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            SearchBar(search: viewModel.typeSelect == .popular ? $viewModel.searchPopular : $viewModel.searchTopRated, showFilters: $viewModel.showFilters, callback: { search in
                viewModel.searchMovies(search: search)
            })
            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
            
        }.edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $viewModel.showFilters) {
                FiltersView()
                    .environmentObject(viewModel)
            }
    }
    
    @ViewBuilder
    func PickerView() -> some View {
        
        Picker("Select Movie Type", selection: $viewModel.typeSelect) {
            Text("Popular")
                .tag(MovieType.popular)
            Text("Top Rated")
                .tag(MovieType.topRated)
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    func ScrollPopularMovies() -> some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                
                ForEach(viewModel.popularMovies, id: \.id) { movies in
                    
                    MovieCard(movie: movies)
                        .environmentObject(viewModel)
                }
                
            }.padding(16)
        }
    }
    
    @ViewBuilder
    func ScrollTopRatedMovies() -> some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                
                ForEach(viewModel.topRatedMovies, id: \.id) { movies in
                    
                    MovieCard(movie: movies)
                        .environmentObject(viewModel)
                }
                
            }.padding(16)
        }
    }
}

#Preview {
    HomeMovies()
}
