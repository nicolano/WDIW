//
//  SwiftUIView.swift
//  WDIW
//
//  Created by Nicolas von Trott on 22.05.24.
//

import SwiftUI

struct ContentHero: View {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    let content: MediaContent
        
    var body: some View {
        ScrollView {
            ContentSwitch(content: .constant(content), bookContent: { book in
                HeroBookContent(book: book.wrappedValue)
            }, movieContent: { movie in
                HeroMovieContent(movie: movie.wrappedValue)
            }, seriesContent: { series in
                HeroSeriesContent(series: series.wrappedValue)
            })
            .padding(.HorizontalM)
        }
        .safeAreaInset(edge: .top, content: { header })
        .background {
            RoundedRectangle(cornerRadius: .CornerRadius.dialog)
                .fill(Color.clear)
                .glassEffect(.regular, in: .rect(cornerRadius: .CornerRadius.dialog))
        }
        .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.dialog))
        .padding(.HorizontalM)
        .padding(.VerticalXL)
    }
}

extension ContentHero {
    private var header: some View {
        HStack {
            Button {
                navigationVM.closeSelectedContentHero()
            } label: {
                Image(systemName: "xmark")
                    .padding(.AllM)
            }
            .glassEffect(.regular)
            
            Spacer()
            
            Button {
                navigationVM.openEditContentSheet(content: content)
            } label: {
                Label("Edit", systemImage: "pencil")
                    .padding(.AllM)
            }
            .glassEffect(.regular)
        }
        .bold()
        .padding(.AllM)
    }
}


struct ContentHeroViewModifier: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel

    var isShown: Bool {
        !(navigationVM.selectedContent == nil)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isShown ? 5 : 0)
                .allowsHitTesting(isShown ? false : true)
            
            if let mediaContent = navigationVM.selectedContent {
                ContentHero(content: mediaContent)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(10000000000)
                    .geometryGroup()
            }
        }
    }
}

extension View {
    func contentHero() -> some View {
        modifier(ContentHeroViewModifier())
    }
}
