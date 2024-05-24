//
//  WikipediaContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 22.05.24.
//

import SwiftUI

struct WikipediaContent: View {
    let contentFor: String
    
    @State var isOpen: Bool = false
    @State var contentIsLoading: Bool = true
    
    @State private var result: WikiResult? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack.spacingS(alignment: .bottom) {
                Text("Wikipedia")
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
                    if let url = URL(string: "\(WIKI_URL_PAGE)\(result.key ?? "")") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack.spacingS(alignment: .top) {
                        if let url = result.thumbnail?.url {
                            AsyncImage(url: URL(string: "https:\(url)")) { phase in
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

                        VStack.spacingXS(alignment: .leading) {
                            Text(result.description?.localizedCapitalized ?? "")
                                .multilineTextAlignment(.leading)
                        }
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

fileprivate let language = "en"
fileprivate let limit = "1"
fileprivate let WIKI_URL_SEARCH = "https://api.wikimedia.org/core/v1/wikipedia/\(language)/search/page?q="
fileprivate let WIKI_URL_PAGE = "https://wikipedia.org/wiki/"

extension WikipediaContent {
    private func loadData(_ forContent: String) async {
        guard let url = URL(string: "\(WIKI_URL_SEARCH)\(forContent)&limit=\(limit)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(WikiResponse.self, from: data) {
                result = decodedResponse.pages.first
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct WikiResponse: Decodable {
    let pages: [WikiResult]
}

struct WikiResult: Decodable {
    let id: Int?
    let key: String?
    let title: String?
    let excerpt: String?
    let matched_title: String?
    let description: String?
    let thumbnail: WikiThumbnail?
}

struct WikiThumbnail: Decodable {
    let mimetype: String?
    let size: Int?
    let width: Int?
    let height: Int?
    let duration: Int?
    let url: String?
}
