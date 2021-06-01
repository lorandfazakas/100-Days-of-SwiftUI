//
//  Order.swift
//  CupcakeCorner
//
//  Created by Lorand Fazakas on 2021. 05. 31..
//

import Foundation

class Order: ObservableObject, Codable {
    @Published var details = OrderDetails()
    
    enum CodingKeys: CodingKey {
        case orderDetails
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        details = try container.decode(OrderDetails.self, forKey: .orderDetails)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(details, forKey: .orderDetails)
    }

}
