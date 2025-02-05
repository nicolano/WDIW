//
//  IMDbContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

struct IMDbContent: View {
    let contentFor: String
    
    @State var isOpen: Bool = false
    @State var contentIsLoading: Bool = true
    
    @State private var searchResult: OmdbSearchResult? = nil
    @State private var dataResult: OmdbIdResult? = nil

    let omdbFetcher = OmdbFetcher()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack.spacingS(alignment: .bottom) {
                Text("IMDb")
                    .font(.headline)
                
                Text(contentFor)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if let rating = dataResult?.imdbRating {
                    Text(rating) + Text("/10")
                }
                
                if contentIsLoading {
                    ProgressView()
                        .foregroundStyle(Color.secondary)
                } else if searchResult == nil {
                    Image(systemName: "questionmark")
                        .foregroundStyle(Color.secondary)
                } else {
                    Button {
                        withAnimation {
                            isOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .rotationEffect(isOpen ? Angle(degrees: 0) : Angle(degrees: -90))
                            .bold()
                    }
                }
            }

            if let searchResult, isOpen {
                Button {
                    if let url = URL(string: omdbFetcher.getImdbUrl(forSearchResult: searchResult)) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack.spacingS(alignment: .center) {
                        ThumbnailContent(url: searchResult.Poster)

                        VStack(alignment: .leading) {
                            Text(searchResult.Title?.localizedCapitalized ?? "")
                                .bold()
                            
                            Text(dataResult?.Plot ?? "")
                                .foregroundStyle(Color.primary)
                        }
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding(.TopS)
            }
        }
        .task {
            await searchResult = omdbFetcher.searchTitle(contentFor)
            
            if let imdbID = searchResult?.imdbID {
                await dataResult = omdbFetcher.loadDataForTitle(imdbId: imdbID)
            }
            
            contentIsLoading = false
        }
    }
}
