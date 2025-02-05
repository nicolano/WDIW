//
//  IMDbViewModel.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftUI

fileprivate let omdbApiKey = "&apikey=16fd7e05"
fileprivate let omdbUrl = "https://www.omdbapi.com/"
fileprivate let imdbUrl = "https://www.imdb.com/title/"

struct OmdbFetcher {
    private func buildOmdbUrl(parameter: String) -> String {
        return omdbUrl + "?" + parameter + omdbApiKey
    }
    
    func getImdbUrl(forSearchResult searchResult: OmdbSearchResult) -> String {
        return "\(imdbUrl)\(searchResult.imdbID ?? "")"
    }
    
    func searchTitles(_ forContent: String) async -> [OmdbSearchResult] {
        guard let url = URL(string: buildOmdbUrl(parameter: "s=\(forContent)")) else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(OmdbSearchResponse.self, from: data) {
                return decodedResponse.Search
            }
        } catch {
            print("Error Decoding data:" + String(describing: error))
        }
        
        return []
    }
    
    func searchTitle(_ forContent: String) async -> OmdbSearchResult? {
        guard let url = URL(string: buildOmdbUrl(parameter: "s=\(forContent)")) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(OmdbSearchResponse.self, from: data) {
                return decodedResponse.Search.first
            }
        } catch {
            print("Error Decoding data:" + String(describing: error))
        }
        
        return nil
    }
    
    func loadDataForTitle(imdbId: String) async -> OmdbIdResult? {
        print(buildOmdbUrl(parameter: "i=\(imdbId)"))
        guard let url = URL(string: buildOmdbUrl(parameter: "i=\(imdbId)")) else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(OmdbIdResult.self, from: data) {
                return decodedResponse
            }
        } catch {
            print("Error Decoding data:" + String(describing: error))
        }
        
        return nil
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
