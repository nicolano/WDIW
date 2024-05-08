//
//  RatingEditor.swift
//  WDIW
//
//  Created by Nicolas von Trott on 08.05.24.
//

import SwiftUI

struct RatingEditor: View {
    init(value: Binding<Double>, title: String? = nil) {
        self._value = value
        self.title = title
    }
    
    @Binding var value: Double
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
                    Button {
                        value = Double(number)
                    } label: {
                        HStack {
                            Spacer(minLength: 0)
                            
                            Image(systemName: value >= Double(number) ? "star.fill" : "star")
                                .foregroundStyle(Color.yellow)
                            
                            Spacer(minLength: 0)
                        }

                    }
                }
            }
        }
    }
}
