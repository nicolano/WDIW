//
//  IMDbContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 24.05.24.
//

import SwiftUI

fileprivate let omdbApiKey = "16fd7e05"
fileprivate let omdbUrl = "https://www.omdbapi.com/?i=tt3896198&apikey=16fd7e05&"

struct IMDbContent: View {
    let contentFor: String
    
    @State var isOpen: Bool = false
    @State var contentIsLoading: Bool = true
    
    @State private var result: OmdbResult? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack.spacingS(alignment: .bottom) {
                Text("IMDb")
                    .font(.headline)
                
                Text(contentFor)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if contentIsLoading {
                    ProgressView()
                        .foregroundStyle(Color.secondary)
                } else if result == nil {
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

            if let result, isOpen {
                Button {
//                    if let url = URL(string: "\(omdbUrl)s=\(result.key ?? "")") {
//                        UIApplication.shared.open(url)
//                    }
                } label: {
                    VStack.spacingXS(alignment: .leading) {
                        Text(result.imdbId?.localizedCapitalized ?? "")
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.TopS)
            }
        }
        .task {
            await loadData(contentFor)
            contentIsLoading = false
        }
    }
}

extension IMDbContent {
    private func loadData(_ forContent: String) async {
        guard let url = URL(string: "\(omdbUrl)s=\(forContent)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8))
            if let decodedResponse = try? JSONDecoder().decode(OmdbResponse.self, from: data) {
                result = decodedResponse.search.first
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct OmdbResponse: Decodable {
    let search: [OmdbResult]
}

struct OmdbResult: Decodable {
    let year: Int?
    let imdbId: String?
    let type: String?
    let poster: String?
}
