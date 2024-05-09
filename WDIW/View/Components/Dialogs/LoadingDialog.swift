//
//  LoadingDialog.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct LoadingDialogViewModifier: ViewModifier {
    let isShown: Bool
    
    func body(content: Content) -> some View {
        content
            .blur(radius: isShown ? 5 : 0)
            .overlay {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        if isShown {
                            ProgressView()
                                .padding(.AllXL)
                                .background(Color.Custom.surface)
                                .cornerRadius(.CornerRadius.dialog)
                        }
                        
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        
    }
}

extension View {
    func loadingDialog(_ isShown: Bool) -> some View {
        modifier(LoadingDialogViewModifier(isShown: isShown))
    }
}
