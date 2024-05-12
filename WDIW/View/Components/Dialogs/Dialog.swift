//
//  Dialog.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

struct Dialog<Background: View, DialogContent: View>: View {
    @Namespace var namespace
    
    let isShown: Bool
    @ViewBuilder let backgroundContent: Background
    @ViewBuilder let dialogContent: DialogContent
    
    var body: some View {
        ZStack {
            backgroundContent
                .blur(radius: isShown ? 5 : 0)
                .overlay {
                    Group {
                        if isShown {
                            dialogContent
                                .background {
                                    RoundedRectangle(cornerRadius: .CornerRadius.dialog)
                                        .fill(Color.Custom.surface)
                                        .matchedGeometryEffect(id: "shape", in: namespace)
                                }
                                .padding(.AllL)
                                .align(.center)
                        }
                    }
                }
        }
    }
}

