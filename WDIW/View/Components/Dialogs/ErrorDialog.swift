//
//  ErrorDialog.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

struct ErrorDialogViewModifier: ViewModifier {
    @State private var errorText: String? = nil
    
    func body(content: Content) -> some View {
        Dialog(isShown: errorText != nil) {
            content
        } dialogContent: {
            VStack.spacingM {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                
                Text(errorText ?? "")
                    .multilineTextAlignment(.center)
                
                Button {
                    errorText = nil
                } label: {
                    Text("Ok")
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .padding(.AllM)
        }
        .onPreferenceChange(ErrorPreferenceKey.self) { it in
            if errorText != nil {
                return
            }
            
            withAnimation {
                errorText = it
            }
        }
    }
}

extension View {
    func errorDialog() -> some View {
        modifier(ErrorDialogViewModifier())
    }
}
