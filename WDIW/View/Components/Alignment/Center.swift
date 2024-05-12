//
//  Center.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

enum AlignmentType {
    case center, hCenter, vCenter, leading, trailing, top, bottom, topLeading, topTrailing, bottomLeading, bottomTrailing
}

struct AlignmentViewModifier: ViewModifier {
    let alignmentType: AlignmentType
    
    func body(content: Content) -> some View {
        ZStack {
            switch alignmentType {
            case .center:
                HStack.zeroSpacing {
                    Spacer(minLength: 0)
                    VStack.zeroSpacing {
                        Spacer(minLength: 0)
                        content
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
            case .hCenter:
                HStack.zeroSpacing {
                    Spacer(minLength: 0)
                    content
                    Spacer(minLength: 0)
                }
            case .vCenter:
                VStack.zeroSpacing {
                    Spacer(minLength: 0)
                    content
                    Spacer(minLength: 0)
                }
            case .leading:
                HStack.zeroSpacing {
                    content
                    Spacer(minLength: 0)
                }
            case .trailing:
                HStack.zeroSpacing {
                    Spacer(minLength: 0)
                    content
                }
            case .top:
                VStack.zeroSpacing {
                    content
                    Spacer(minLength: 0)
                }
            case .bottom:
                VStack.zeroSpacing {
                    Spacer(minLength: 0)
                    content
                }
            case .topLeading:
                HStack.zeroSpacing {
                    VStack.zeroSpacing {
                        content
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
            case .topTrailing:
                HStack.zeroSpacing {
                    Spacer(minLength: 0)
                    VStack.zeroSpacing {
                        content
                        Spacer(minLength: 0)
                    }
                }
            case .bottomLeading:
                HStack.zeroSpacing {
                    VStack.zeroSpacing {
                        Spacer(minLength: 0)
                        content
                    }
                    Spacer(minLength: 0)
                }
            case .bottomTrailing:
                HStack.zeroSpacing {
                    Spacer(minLength: 0)
                    VStack.zeroSpacing {
                        Spacer(minLength: 0)
                        content
                    }
                }
            }
        }
    }
}

extension View {
    func align(_ alignmentType: AlignmentType) -> some View {
        modifier(AlignmentViewModifier(alignmentType: alignmentType))
    }
}
