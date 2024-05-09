//
//  DeleteButton.swift
//  WDIW
//
//  Created by Nicolas von Trott on 09.05.24.
//

import SwiftUI

struct DeleteButton: View {
    let onPress: () -> Void
    
    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                Spacer()
                
                Label(
                    title: { Text("Delete") },
                    icon: { Image(systemName: "trash.fill") }
                )
                .foregroundStyle(Color.red)
                .padding(.AllS)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.red.opacity(0.3))
                }
            }
            
        }
    }
}


