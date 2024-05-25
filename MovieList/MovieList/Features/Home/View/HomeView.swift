//
//  HomeView.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @StateObject var viewModel = MovieViewModel()
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 156))
    ]
    
    var body: some View {
        
        NavigationView {
         
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
                
            }.background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
                .background(Color.red)
                .sheet(isPresented: $viewModel.showFilters) {
                    FiltersView()
                        .environmentObject(viewModel)
                }
                .navigationTitle(LocalizedStringKey("Movies"))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func PickerView() -> some View {
        
        Picker(LocalizedStringKey("Select movie type"), selection: $viewModel.typeSelect) {
            Text(LocalizedStringKey("Popular"))
                .tag(MovieType.popular)
            Text(LocalizedStringKey("Top rated"))
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
    HomeView()
}
