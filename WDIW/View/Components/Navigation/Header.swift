//
//  Header.swift
//  WDIW
//
//  Created by Nicolas von Trott on 21.02.24.
//

import SwiftUI

struct Header<Content1: View>: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    let title: String
    @ViewBuilder let buttons: Content1
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.black)
                .transaction { trans in
                    trans.animation = .none
                }
            
            Spacer()
            
            buttons
        }
        .padding(.horizontal, .Spacing.m)
        .padding(.top, safeAreaInsets.top)
        .padding(.top, .Spacing.m)
        .padding(.bottom, .Spacing.m)
    }
}
