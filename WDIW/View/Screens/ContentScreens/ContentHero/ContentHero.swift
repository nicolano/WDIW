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
    
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        // TODO: Remove Scroll View Offset if not needed
        VerticalScrollView($scrollViewOffset) {
            ContentSwitch(content: .constant(content), bookContent: { book in
                HeroBookContent(book: book.wrappedValue)
            }, movieContent: { movie in
                HeroMovieContent(movie: movie.wrappedValue)
            }, seriesContent: { series in
                HeroSeriesContent(series: series.wrappedValue)
            })
            .padding(.HorizontalM)
        }
        .safeAreaInset(edge: .top, content: { header(scrollViewOffset) })
        .background {
            RoundedRectangle(cornerRadius: .CornerRadius.dialog)
                .fill(Color.Custom.surface)
        }
        .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.dialog))
        .padding(.HorizontalM)
        .padding(.VerticalXL)
    }
}

extension ContentHero {
    private func header(_ scrollViewOffset: CGFloat) -> some View {
        HStack {
            Button {
                navigationVM.closeSelectedContentHero()
            } label: {
                Image(systemName: "x.circle.fill")
            }
            
            Spacer()
            
            Button {
                navigationVM.openEditContentSheet(content: content)
            } label: {
                Label("Edit", systemImage: "pencil")
            }
        }
        .bold()
        .padding(.AllM)
        .background(Material.ultraThin)
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
