//
//  CustomTextField.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct CustomTextField<LeadingContent: View, TrailingContent: View>: View {
    init(
        value: Binding<String>,
        title: String? = nil,
        hint: String = "...",
        lineLimit: Int = 1,
        withShadow: Bool = false,
        onSubmit: @escaping () -> Void = {},
        @ViewBuilder leadingContent: @escaping () -> LeadingContent,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent
    ) {
        self._value = value
        self.title = title
        self.hint = hint
        self.lineLimit = lineLimit
        self.withShadow = withShadow
        self.onSubmit = onSubmit
        self.leadingContent = leadingContent
        self.trailingContent = trailingContent
    }
    
    @Binding var value: String
    private let title: String?
    private let hint: String
    private let lineLimit: Int
    private let withShadow: Bool
    private let onSubmit: () -> Void
    private let leadingContent: () -> LeadingContent
    private let trailingContent: () -> TrailingContent

    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack.zeroSpacing {
            if let title = title {
                Text(title)
                    .bold()
                    .align(.leading)
                    .padding(.BottomXS)
            }
            
            HStack {
                leadingContent()
                
                
                TextField(hint, text: Binding(get: {
                    value
                }, set: { newValue in
                    if let _ = newValue.lastIndex(of: "\n") {
                        isFocused = false
                        onSubmit()
                    } else {
                        value = newValue
                    }
                }) , axis: .vertical)
                    .lineLimit(lineLimit, reservesSpace: true)
                    .multilineTextAlignment(.leading)
                    .submitLabel(.done)
                    .focused($isFocused)

                trailingContent()
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
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
//                    self.isFocused = true
//                }
//            }
        }
    }
}

extension CustomTextField where TrailingContent == EmptyView {
    init(
        value: Binding<String>,
        title: String? = nil,
        hint: String = "...",
        lineLimit: Int = 1,
        withShadow: Bool = false,
        onSubmit: @escaping () -> Void = {},
        @ViewBuilder leadingContent: @escaping () -> LeadingContent
    ) {
        self._value = value
        self.title = title
        self.hint = hint
        self.lineLimit = lineLimit
        self.withShadow = withShadow
        self.onSubmit = onSubmit
        self.leadingContent = leadingContent
        self.trailingContent = {EmptyView()}
    }
}

extension CustomTextField where LeadingContent == EmptyView {
    init(
        value: Binding<String>,
        title: String? = nil,
        hint: String = "...",
        lineLimit: Int = 1,
        withShadow: Bool = false,
        onSubmit: @escaping () -> Void = {},
        @ViewBuilder trailingContent: @escaping () -> TrailingContent
    ) {
        self._value = value
        self.title = title
        self.hint = hint
        self.lineLimit = lineLimit
        self.withShadow = withShadow
        self.onSubmit = onSubmit
        self.leadingContent = {EmptyView()}
        self.trailingContent = trailingContent
    }
}

extension CustomTextField where LeadingContent == EmptyView, TrailingContent == EmptyView {
    init(
        value: Binding<String>,
        title: String? = nil,
        hint: String = "...",
        lineLimit: Int = 1,
        withShadow: Bool = false,
        onSubmit: @escaping () -> Void = {}
    ) {
        self._value = value
        self.title = title
        self.hint = hint
        self.lineLimit = lineLimit
        self.withShadow = withShadow
        self.onSubmit = onSubmit
        self.leadingContent = {EmptyView()}
        self.trailingContent = {EmptyView()}
    }
}
