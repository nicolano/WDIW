//
//  LoadingDialog.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct LoadingDialogViewModifier: ViewModifier {
    @State private var isShown: Bool = false
    
    func body(content: Content) -> some View {
        Dialog(isShown: isShown) {
            content
        } dialogContent: {
            ProgressView()                                    
                .padding(.AllL)
        }
        .onPreferenceChange(LoadingPreferenceKey.self) { isLoading in
            if let isLoading = isLoading {
                withAnimation {
                    isShown = isLoading
                }
            }
        }
    }
}

extension View {
    func loadingDialog() -> some View {
        modifier(LoadingDialogViewModifier())
    }
}
