//
//  FilterResortView.swift
//  SnowSeeker
//
//  Created by Lorand Fazakas on 2021. 07. 18..
//

import SwiftUI

struct FilterResortView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var filterPickerSelection: FilterType = .country
    
    var resorts: [Resort]
    @Binding var countryFilters: [String]
    @Binding var priceFilters: [String]
    @Binding var sizeFilters: [String]
    
    private var availableCountries: [String] {
        let countriesSet = Set(resorts.map { $0.country })
        return Array(countriesSet).sorted { $0 < $1}
    }
    
    private var availableSizes: [String] {
        let sizesSet = Set(resorts.map { $0.sizeText })
        return Array(sizesSet).sorted { $0 < $1}
    }
    
    private var availablePrices: [String] {
        let pricesSet = Set(resorts.map { $0.priceText })
        return Array(pricesSet).sorted { $0 < $1}
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filter by")) {
                    Picker("Filter Resorts", selection: $filterPickerSelection) {
                        Text("Country").tag(FilterType.country)
                        Text("Price").tag(FilterType.price)
                        Text("Size").tag(FilterType.size)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    switch filterPickerSelection {
                    case .country:
                        FilterValuesList(values: availableCountries, selections: $countryFilters)
                    case .price:
                        FilterValuesList(values: availablePrices, selections: $priceFilters)
                    case .size:
                        FilterValuesList(values: availableSizes, selections: $sizeFilters)
                    }
                }
            }
            .navigationBarTitle(Text("Filter Resorts"))
            .navigationBarItems(leading: Button("Clear filters") {
                countryFilters = []
                sizeFilters = []
                priceFilters = []
            }.foregroundColor(.red)
            ,trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct FilterValuesList: View {
    let values: [String]
    @Binding var selections: [String]
    
    var body: some View {
        Group {
            ForEach(values, id: \.self) { value in
                HStack {
                    Text(value)
                    Spacer()
                    if selections.contains(value) {
                        Image(systemName: "checkmark.circle")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggle(selection: value)
                }
            }
        }
    }
    
    func toggle(selection: String) {
        if let firstIndex = selections.firstIndex(of: selection) {
            selections.remove(at: firstIndex)
        } else {
            selections.append(selection)
        }
        
    }
}

struct FilterResortView_Previews: PreviewProvider {
    static var previews: some View {
        FilterResortView(resorts: [], countryFilters: .constant([]), priceFilters: .constant([]), sizeFilters: .constant([]))
    }
}
