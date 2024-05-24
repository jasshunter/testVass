//
//  MoviesView.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct MoviesView: View {
    
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            PickerView()
            
            TabView(selection: $viewModel.typeSelect) {
                
                ScrollPopularMovies()
                    .tag(MovieType.popular)
                ScrollTopRatedMovies()
                    .tag(MovieType.topRated)
                
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }.onAppear() {
            viewModel.getPopularMovies()
            viewModel.getTopRatedMovies()
        }
        .edgesIgnoringSafeArea(.bottom)
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
            
            LazyVStack(spacing: 16) {
                
                ForEach((viewModel.popularMovies?.results ?? []), id: \.id) { movies in
                    
                    MovieCard(movie: movies)
                        .environmentObject(viewModel)
                }
            }
            
        }
    }
    
    @ViewBuilder
    func ScrollTopRatedMovies() -> some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            LazyVStack(spacing: 16) {
                
                ForEach((viewModel.topRatedMovies?.results ?? []), id: \.id) { movies in
                    
                    MovieCard(movie: movies)
                        .environmentObject(viewModel)
                }
            }
            
        }
    }
}

#Preview {
    MoviesView()
}
