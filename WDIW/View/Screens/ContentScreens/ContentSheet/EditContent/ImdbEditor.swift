//
//  ImdbEditor.swift
//  WDIW
//
//  Created by Nicolas von Trott on 04.02.25.
//

import SwiftUI

struct ImdbEditor: View {
    @EnvironmentObject private var settingsVM: SettingsViewModel
    
    var linkedWithImdb: Bool
    
    var body: some View {
        VStack.spacingXS {
            HStack {
                Text(linkedWithImdb ? "Linked with Imdb" : "Link with IMDB")
                    .bold()
                    .align(.leading)
                    .padding(.BottomXS)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: linkedWithImdb ? "link" : "link.badge.plus")
                        .font(.title)
                        .foregroundColor(linkedWithImdb ? .primary : settingsVM.preferredAccentColor)
                }
            }
        }
    }
}
