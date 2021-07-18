//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Lorand Fazakas on 2021. 07. 16..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var sort: SortType = .default
    @State private var showingSortActionSheet = false
    @State private var showingFilterSheet = false
    
    @State var countryFilters = [String]()
    @State var priceFilters = [String]()
    @State var sizeFilters = [String]()
    
    var sortedResorts: [Resort] {
        switch sort {
        case .default:
            return resorts
        case .name:
            return resorts.sorted { $0.name < $1.name }
        case .country:
            return resorts.sorted { $0.country < $1.country }
        }
    }
    
    var sortedAndFilteredResorts: [Resort] {
        var list = sortedResorts
        if !countryFilters.isEmpty {
            list = list.filter { countryFilters.contains($0.country) }
        }
        if !priceFilters.isEmpty {
            list = list.filter { priceFilters.contains($0.priceText) }
        }
        
        if !sizeFilters.isEmpty {
            list = list.filter { sizeFilters.contains($0.sizeText) }
        }
        return list
    }
    
    
    var body: some View {
        NavigationView {
            List(sortedAndFilteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading:
                                    Button("Sort") {
                                        showingSortActionSheet = true
                                    }, trailing:
                                        Button("Filter") {
                                            showingFilterSheet = true
                                        })
            .actionSheet(isPresented: $showingSortActionSheet) {
                ActionSheet(title: Text("How do you want to sort them?"), buttons: [
                    .default(Text("Name")) { sort = .name },
                    .default(Text("Country")) { sort = .country },
                    .default(Text("Default")) { sort = .default},
                    .cancel()
                ])
            }
            .sheet(isPresented: $showingFilterSheet) {
                FilterResortView(resorts: resorts, countryFilters: $countryFilters, priceFilters: $priceFilters, sizeFilters: $sizeFilters)
            }
            
            WelcomeView()
        }
        //        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }

}

enum FilterType {
    case country, size, price
}

enum SortType {
    case name, country, `default`
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
