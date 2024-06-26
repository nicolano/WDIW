//
//  ThumbnailContent.swift
//  WDIW
//
//  Created by Nicolas von Trott on 26.06.24.
//

import SwiftUI

struct ThumbnailContent: View {
    let url: String?
    
    var body: some View {
        if let url = url {
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
    }
}
