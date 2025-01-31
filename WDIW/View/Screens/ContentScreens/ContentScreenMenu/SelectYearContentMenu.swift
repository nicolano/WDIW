//
//  SelectYearContentMenu.swift
//  WDIW
//
//  Created by Nicolas von Trott on 31.01.25.
//

import SwiftUI

struct SelectYearContentMenu: View {
    @EnvironmentObject private var contentScreenVM: ContentScreenViewModel
    
    let contentCategory: ContentCategories
    
    func getYearDescription() -> String {
        if contentScreenVM.selectedYears == contentScreenVM.yearsWithEntry {
            return "All"
        } else {
            var yearDescription: String = ""
            for (index, year) in contentScreenVM.selectedYears.enumerated() {
                if index == 0 {
                    yearDescription += "\(year)"
                } else if index == contentScreenVM.selectedYears.count - 1 {
                    yearDescription += " and \(year)"
                } else {
                    yearDescription += ", \(year)"
                }
            }
            
            return yearDescription
        }
    }
    
    var body: some View {
        Menu {
            if contentScreenVM.selectedYears == contentScreenVM.yearsWithEntry {
                Button {
                    contentScreenVM.selectCurrentYear()
                } label: {
                    Text("Show current")
                }
            } else {
                Button {
                    contentScreenVM.selectAllYears()
                } label: {
                    Text("Show all")
                }
            }
    
            Divider()
            
            ForEach(contentScreenVM.yearsWithEntry, id: \.self) { year in
                Button {
                    contentScreenVM.selectYear(year: year)
                } label: {
                    Label(year, systemImage: contentScreenVM.selectedYears.contains(year) ? "checkmark" : "")
                }
                .menuActionDismissBehavior(.disabled)
            }
        } label : {
            Label("Year", systemImage: "calendar")
            Text(getYearDescription())
                .lineLimit(2)
        }
    }
}
