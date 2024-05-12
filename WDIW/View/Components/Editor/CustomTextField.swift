//
//  CustomTextField.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct CustomTextField: View {
    init(value: Binding<String>, title: String? = nil, hint: String = "...") {
        self._value = value
        self.title = title
        self.hint = hint
    }
    
    @Binding var value: String
    private let title: String?
    private let hint: String
    
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
                RoundedRectangle(cornerRadius: .CornerRadius.textField)
                    .fill(Material.ultraThin)
            }
        }
    }
}

#Preview {
    CustomTextField(value: .constant(""))
}
