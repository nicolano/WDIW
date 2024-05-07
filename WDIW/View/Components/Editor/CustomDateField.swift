//
//  CustomDateField.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct CustomDateField: View {
    init(value: Binding<Date>, title: String? = nil, hint: String = "...") {
        self._value = value
        self.title = title
        self.hint = hint
    }
    
    @Binding var value: Date
    private let title: String?
    private let hint: String
    
    var body: some View {
        DatePicker(selection: $value, displayedComponents: .date) {
            if let title = title {
                Text(title)
                    .bold()
            }
        }
    }
}

#Preview {
    CustomDateField(value: .constant(Date()), title: "Date")
}
