//
//  PredictionsLists.swift
//  WDIW
//
//  Created by Nicolas von Trott on 01.07.24.
//

import SwiftUI

struct PredictionsLists: View {
    let predictions: [String]
    let onTap: (_ index: Int) -> Void
    
    var body: some View {
        Group {
            if predictions.count > 0 {
                List(0..<predictions.count, id: \.self) { index in
                    Text(predictions[index])
                        .onTapGesture {
                            onTap(index)
                        }
                        .listRowInsets(.none)
                        .listRowSpacing(.Spacing.s)
                        .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: .CornerRadius.textField)
                        .fill(Material.ultraThin)
                        .shadow(color: .black.opacity(0.2), radius: 4)
                )
            }
        }
    }
}
