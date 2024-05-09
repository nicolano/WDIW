//
//  RatingEditor.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct RatingEditor: View {
    init(value: Binding<Int>, title: String? = nil) {
        self._value = value
        self.title = title
    }
    
    @Binding var value: Int
    private let title: String?
    
    var body: some View {
        VStack.spacingXS {
            if let title = title {
                HStack {
                    Text(title)
                        .bold()
                    
                    Spacer()
                }
                .padding(.BottomXS)
            }
            
            HStack.zeroSpacing {
                ForEach(1..<11, id: \.self) { number in
                    HStack {
                        Spacer(minLength: 0)

                        FavButton(isActive: value >= number) {
                            withAnimation {
                                value = number
                            }
                        }
                        
                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }
}
