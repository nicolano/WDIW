//
//  CSVInfoSheet.swift
//  WDIW
//
//  Created by Nicolas von Trott on 12.05.24.
//

import SwiftUI

struct CSVInfoSheet: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack.zeroSpacing {
            Image("CSV")
                .resizable()
                .scaledToFit()
                .overlay {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.headline)
                            .foregroundStyle(Color.accentColor)
                    }
                    .align(.topTrailing)
                    .padding(.AllS)
                }
            
            ScrollView {
                VStack.spacingM(alignment: .leading) {
                    Text("CSV Explained")
                        .font(.headline)

                    Text("A CSV (Comma-Separated Values) file is a simple text format used to store tabular data, like a spreadsheet. Each line in a CSV file represents a row, and the values within each row are separated by commas (or sometimes other delimiters like semicolons or tabs). It's a popular format for data exchange between different software systems because it's easy to read and write programmatically, and it can be opened and edited with common applications like Microsoft Excel or Google Sheets.")
                }
                .align(.leading)
                .multilineTextAlignment(.leading)
                .padding(.TopL)
                .padding(.HorizontalM)
                
                Spacer()
            }
        }
    }
}
