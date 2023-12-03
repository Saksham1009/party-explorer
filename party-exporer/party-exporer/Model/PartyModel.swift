//
//  PartyModel.swift
//  party-exporer
//
//  Created by Saksham Dua on 2023-12-03.
//

import Foundation

public struct PartyModel {
    var name: String
    var bannerImage: URL
    var price: Double
    var startDate: Date
    var endDate: Date?
    
    public init(
        name: String,
        bannerImage: URL,
        price: Double,
        startDate: Date,
        endDate: Date? = nil
    ) {
        self.name = name
        self.bannerImage = bannerImage
        self.price = price
        self.startDate = startDate
        self.endDate = endDate
    }
}
