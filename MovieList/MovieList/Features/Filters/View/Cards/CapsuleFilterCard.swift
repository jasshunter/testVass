//
//  CapsuleFilterCard.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct CapsuleFilterCard: View {
    
    var filter: String
    @Binding var selectFilter: String?
    private var colorSelect: Color {
        selectFilter == filter ? Color.green : Color.black
    }
    
    var body: some View {
        
        Button(action: {
            
            selectFilter = selectFilter == filter ? nil : filter
        }) {
            
            Text(filter)
                .foregroundColor(colorSelect)
            
        }.padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                .stroke(colorSelect, lineWidth: 1)
            )
    }
}

#Preview {
    CapsuleFilterCard(filter: "Filtro", selectFilter: .constant(""))
}
