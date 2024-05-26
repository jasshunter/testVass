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
        
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing: 0) {
                
                WebImage(url: viewModel.getImageUrl(movie.posterPath))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 236)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(movie.originalTitle ?? "")
                        .bold()
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(movie.releaseDate ?? "")
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
            }
            
            CircularProgress(progress: viewModel.getVoteAverage(movie.voteAverage))
                .padding(.top, 220)
                .padding(.trailing, 16)
            
        }.frame(height: 336)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
    }
}

#Preview {
    MovieCard(movie: MovieMocks().createMockMovie())
        .frame(width: 156, height: 336)
        .environmentObject(MovieViewModel())
}
