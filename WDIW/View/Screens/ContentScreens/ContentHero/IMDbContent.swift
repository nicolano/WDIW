//
//  IMDbContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

fileprivate let omdbApiKey = "&apikey=16fd7e05"
fileprivate let omdbUrl = "https://www.omdbapi.com/"
fileprivate let imdbUrl = "https://www.imdb.com/title/"

fileprivate func buildOmdbUrl(parameter: String) -> String {
    return omdbUrl + "?" + parameter + omdbApiKey
}

struct IMDbContent: View {
    let contentFor: String
    
    @State var isOpen: Bool = false
    @State var contentIsLoading: Bool = true
    
    @State private var searchResult: OmdbSearchResult? = nil
    @State private var dataResult: OmdbIdResult? = nil

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
                    if let url = URL(string: "\(imdbUrl)\(searchResult.imdbID ?? "")") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack.spacingS(alignment: .center) {
                        if let url = searchResult.Poster {
                            AsyncImage(url: URL(string: url)) { phase in
                                switch phase {
                                    case .failure:
                                        EmptyView()
                                    case .success(let image):
                                        image
                                        .resizable()
                                        .scaledToFit()
                                    default:
                                        ProgressView()
                                }
                            }
                            .frame(width: 50)
                        }

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
            await searchTitle(contentFor)
            
            if let imdbID = searchResult?.imdbID {
                await loadDataForTitle(imdbId: imdbID)
            }
            
            contentIsLoading = false
        }
    }
}

extension IMDbContent {
    private func searchTitle(_ forContent: String) async {
        print(buildOmdbUrl(parameter: "s=\(forContent)"))
        guard let url = URL(string: buildOmdbUrl(parameter: "s=\(forContent)")) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(OmdbSearchResponse.self, from: data) {
                searchResult = decodedResponse.Search.first
            }
        } catch {
            print("Error Decoding data:" + String(describing: error))
        }
    }
    
    private func loadDataForTitle(imdbId: String) async {
        print(buildOmdbUrl(parameter: "i=\(imdbId)"))
        guard let url = URL(string: buildOmdbUrl(parameter: "i=\(imdbId)")) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(OmdbIdResult.self, from: data) {
                dataResult = decodedResponse
            }
        } catch {
            print("Error Decoding data:" + String(describing: error))
        }
    }
}

struct OmdbSearchResponse: Decodable {
    let Search: [OmdbSearchResult]
    let totalResults: String?
    let Response: String?
}

struct OmdbSearchResult: Decodable {
    let Title: String?
    let Year: String?
    let imdbID: String?
    let `Type`: String?
    let Poster: String?
}

struct OmdbIdResult: Decodable {
    let Title: String?
    let Year: String?
    let Rated: String?
    let Released: String?
    let Runtime: String?
    let Genre: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Plot: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Poster: String?
    let Ratings: [ImdbRatings]
    let Metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let `Type`: String?
    let DVD: String?
    let BoxOffice: String?
    let Production: String?
    let Website: String?
    let Response: String?
}

struct ImdbRatings: Decodable {
    let Source: String?
    let Value: String?
}
