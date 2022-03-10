//
//  OrderbookAPIResponse.swift
//  FakeBithumbAssignment
//
//  Created by 박예빈 on 2022/03/04.
//

import Foundation

struct OrderbookAPIResponse: Codable {
    let timestamp: String
    let paymentCurrency: String
    let orderCurrency: String
    let bids: [Quote]
    let asks: [Quote]

    enum CodingKeys: String, CodingKey {
        case timestamp
        case paymentCurrency = "payment_currency"
        case orderCurrency = "order_currency"
        case bids, asks
    }
}

struct Quote: Codable {
    var price, quantity: String
    
    init(price: Int, quantity: Double) {
        self.price = "\(price)"
        self.quantity = "\(quantity)"
    }
 }
