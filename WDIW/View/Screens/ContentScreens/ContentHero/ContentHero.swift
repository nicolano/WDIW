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
                
            }, seriesContent: { series in
                
            })
            .padding(.HorizontalM)
        }
        .safeAreaInset(edge: .top, content: { header(scrollViewOffset) })
        .background {
            RoundedRectangle(cornerRadius: .CornerRadius.dialog)
                .fill(Color.Custom.surface)
                .matchedGeometryEffect(id: "Background", in: navigationVM.heroAnimation)
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
                withAnimation {
                    navigationVM.closeEditContentSheet()
                }
            } label: {
                Image(systemName: "x.circle.fill")
            }
            
            Spacer()
            
            Button {
                navigationVM.closeEditContentSheet()
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
    let mediaContent: MediaContent?
    
    private var isShown: Bool {
        mediaContent != nil
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: isShown ? 5 : 0)
                .allowsHitTesting(isShown ? false : true)
            
            if let mediaContent {
                ContentHero(content: mediaContent)
                    .transition(.scale)
                    .zIndex(10000000000)
            }
        }
    }
}

extension View {
    func contentHero(content: MediaContent?) -> some View {
        modifier(ContentHeroViewModifier(mediaContent: content))
    }
}
