//
//  InfoDialog.swift
//  WDIW
//
//  Created by Nicolas von Trott on 13.05.24.
//

import SwiftUI

struct InfoDialogViewModifier: ViewModifier {
    @State private var infoText: String? = nil
    
    func body(content: Content) -> some View {
        Dialog(isShown: infoText != nil) {
            content
        } dialogContent: {
            VStack.spacingM {
                Image(systemName: "info.bubble.fill")
                    .font(.largeTitle)
                
                let attrStr = try! AttributedString(
                    markdown: infoText ?? "",
                    options: AttributedString.MarkdownParsingOptions(
                        interpretedSyntax: .inlineOnlyPreservingWhitespace
                    )
                )
                Text(attrStr)
                    .multilineTextAlignment(.center)
                
                Button {
                    infoText = nil
                } label: {
                    Text("Ok")
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .padding(.AllM)
        }
        .onPreferenceChange(InfoPreferenceKey.self) { it in
            if infoText != nil {
                return
            }
            
            withAnimation {
                infoText = it
            }
        }
    }
}

extension View {
    func infoDialog() -> some View {
        modifier(InfoDialogViewModifier())
    }
}
