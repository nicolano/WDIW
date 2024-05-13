//
//  CustomTextField.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct CustomTextField: View {
    init(value: Binding<String>, title: String? = nil, hint: String = "...", withShadow: Bool = false) {
        self._value = value
        self.title = title
        self.hint = hint
        self.withShadow = withShadow
    }
    
    @Binding var value: String
    private let title: String?
    private let hint: String
    private let withShadow: Bool
    
    var body: some View {
        VStack.zeroSpacing {
            if let title = title {
                Text(title)
                    .bold()
                    .align(.leading)
                    .padding(.BottomXS)
            }
            
            TextField(text: $value) {
                Text(hint)
            }
            .padding(.AllS)
            .background {
                if withShadow {
                    RoundedRectangle(cornerRadius: .CornerRadius.textField)
                        .fill(Material.ultraThin)
                        .shadow(color: .black.opacity(0.2), radius: 4)
                } else {
                    RoundedRectangle(cornerRadius: .CornerRadius.textField)
                        .fill(Material.ultraThin)
                }
            }
        }
    }
}

#Preview {
    CustomTextField(value: .constant(""))
}
