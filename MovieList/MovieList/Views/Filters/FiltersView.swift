//
//  FiltersView.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct FiltersView: View {
    
    @EnvironmentObject var viewModel: MovieViewModel
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.changeShowFilters()
                }) {
                    
                    Image(systemName: "xmark")
                        .imageScale(.medium)
                    
                }.padding()
            }
            
            Text(LocalizedStringKey("Filters"))
                .padding(.vertical, 8)
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    ToggleOption(label: LocalizedStringKey("For adults"), isOn: viewModel.typeSelect == .popular ? $viewModel.filterAdultPopular : $viewModel.filterAdultTopRated)
                    
                    Divider()
                    
                    filterOriginalLanguage()
                    
                    Divider()
                    
                    filterVoteAverage()
                    
                }.padding()
            }
            
            Button(action: {
                
                viewModel.filterMovies()
            }) {
                
                Text(LocalizedStringKey("Filter"))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
            }
            
        }.padding(.bottom, 16)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    @ViewBuilder
    func filterOriginalLanguage() -> some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text(LocalizedStringKey("Original language"))
            
            LazyVGrid(columns: adaptiveColumn, spacing: 16) {
                
                ForEach(viewModel.typeSelect == .popular ? viewModel.filterOriginalLanguagePopular : viewModel.filterOriginalLanguageTopRated, id: \.self) { item in
                    
                    CapsuleFilterCard(filter: item, selectFilter: viewModel.typeSelect == .popular ? $viewModel.selectOriginalLanguagePopular : $viewModel.selectOriginalLanguageTopRated)
                }
            }
        }
    }
    
    @ViewBuilder
    func filterVoteAverage() -> some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text(LocalizedStringKey("Vote average"))
            
            Slider(value: viewModel.typeSelect == .popular ? $viewModel.selectVoteAveragePopular : $viewModel.selectVoteAverageTopRated, in: 0...100, step: 5)
            {
                Text(LocalizedStringKey("Vote average"))
            } minimumValueLabel: {
                Text(LocalizedStringKey("0"))
            } maximumValueLabel: {
                Text(LocalizedStringKey("100"))
            }
            
            Text("\(Int(viewModel.typeSelect == .popular ? viewModel.selectVoteAveragePopular : viewModel.selectVoteAverageTopRated))")
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    FiltersView()
        .environmentObject(MovieViewModel())
}
