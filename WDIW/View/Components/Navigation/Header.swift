//
//  Header.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct Header<Content1: View, Content2: View>: View {
    let title: String
    @ViewBuilder let secondaryButton: Content1
    @ViewBuilder let primaryButton: Content2
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.black)
            
            Spacer()
            
            secondaryButton
            
            primaryButton
        }
        .padding(.horizontal, .Spacing.l)
        .padding(.top, .Spacing.l)
        .padding(.bottom, .Spacing.m)
        .frame(height: 95)
    }
}

#Preview {
    Header(title: "Settings") {
        
    } primaryButton: {
        
    }

}
