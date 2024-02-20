//
//  TabBar.swift
//  WDIW
//
//  Created by Nicolas von Trott on 20.02.24.
//

import SwiftUI

struct TabBar: View {
    @State var activeCategory: ContentCategories = .books
        
    var body: some View {
        HStack { 
            TabBarButton(
                contentCategory: .books,
                isActive: activeCategory == .books
            ) {
                
            }
            
            Spacer(minLength: 0)
            
            TabBarButton(
                contentCategory: .movies,
                isActive: activeCategory == .movies
            ) {
                
            }
        
            Spacer(minLength: 0)

            TabBarButton(
                contentCategory: .series,
                isActive: activeCategory == .series
            ) {
                
            }
        }
        .padding(.Spacing.s)
        .background(Material.bar)
        .clipShape(Capsule())
    }
}

#Preview {
    TabBar()
        .padding(.vertical, 100)
        .background(Color.gray)
}
