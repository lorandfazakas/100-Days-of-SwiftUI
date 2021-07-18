//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Lorand Fazakas on 2021. 07. 16..
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(resort.sizeText)")
                .layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceText)")
                .layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
