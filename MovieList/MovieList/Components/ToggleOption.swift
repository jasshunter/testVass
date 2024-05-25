//
//  ToggleOption.swift
//  MovieList
//
//  Created by JASS on 24/05/24.
//

import SwiftUI

struct ToggleOption: View {
    
    var label: String = "Toggle Option"
    @Binding var isOn: Bool
    var disabled: Bool = false
    
    var body: some View {
        
        Toggle(label, isOn: $isOn)
            .disabled(disabled)
    }
}

#Preview {
    ToggleOption(isOn: .constant(false))
}
