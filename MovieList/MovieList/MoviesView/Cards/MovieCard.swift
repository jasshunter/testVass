//
//  MovieCard.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
    
    var movie: Movie
    @EnvironmentObject var viewModel: MovieViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            WebImage(url: viewModel.getImageUrl(movie.posterPath))
                .resizable()
                .scaledToFit()
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.bottom))
    }
}

#Preview {
    MovieCard(movie: MockData().createMockMovie())
        .environmentObject(MovieViewModel())
}
