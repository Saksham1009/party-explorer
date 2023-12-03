//
//  party_exporerApp.swift
//  party-exporer
//
//  Created by Saksham Dua on 2023-12-03.
//

import ComposableArchitecture
import SwiftUI

@main
struct party_exporerApp: App {
    var body: some Scene {
        WindowGroup {
            ExploreFeedView(
                store: Store(
                    initialState: ExploreFeedReducer.State(
                        partyList: [
                            .init(
                                id: UUID(),
                                dataModel: .init(
                                    name: getRandomName(),
                                    bannerImage: URL(string: getRandomImage())!,
                                    price: 45.99,
                                    startDate: Date.now
                                )
                            ),
                            .init(
                                id: UUID(),
                                dataModel: .init(
                                    name: getRandomName(),
                                    bannerImage: URL(string: getRandomImage())!,
                                    price: 13.99,
                                    startDate: Date.now,
                                    endDate: Date.distantFuture
                                )
                            ),
                            .init(
                                id: UUID(),
                                dataModel: .init(
                                    name: getRandomName(),
                                    bannerImage: URL(string: getRandomImage())!,
                                    price: 54,
                                    startDate: Date.now
                                )
                            )
                        ]
                    )
                ) {
                    ExploreFeedReducer()
                })
        }
    }
}
