//
//  SheetManager.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

struct SheetManager: ViewModifier {
    @EnvironmentObject private var navigationVM: NavigationViewModel
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $navigationVM.showCSVInfoSheet, content: {
                CSVInfoSheet()
            })
            .contentSheet(type: .ADD)
            .contentSheet(type: .EDIT)
    }
}

extension View {
    func sheets() -> some View {
        modifier(SheetManager())
    }
}
