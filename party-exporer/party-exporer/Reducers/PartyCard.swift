//
//  PartyCard.swift
//  party-exporer
//
//  Created by Saksham Dua on 2023-12-03.
//

import ComposableArchitecture
import SwiftUI

public struct PartyCardReducer: Reducer {
    public struct State: Equatable, Identifiable {
        public var id: UUID
        var name: String
        var image: URL
        var price: Double
        var startDate: Date
        var endDate: Date?
        
        var dateFormatter = DateFormatter()

        public init(
            id: UUID,
            dataModel: PartyModel
        ) {
            self.id = id
            self.name = dataModel.name
            self.image = dataModel.bannerImage
            self.price = dataModel.price
            self.startDate = dataModel.startDate
            self.endDate = dataModel.endDate
        }
    }
    
    public enum Action { }
    
    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

struct PartyCardView: View {
    
    let store: StoreOf<PartyCardReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                AsyncImage(url: viewStore.image) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable ()
                            .scaleEffect(2.5)
                            .blur(radius: 40)
                            .cornerRadius(14)
                            .opacity(0.7)
                    default:
                        ZStack {
                            Color.white
                            Text("Loading Party...")
                                .font(.headline)
                        }
                        .frame (height: 250)
                        .cornerRadius (14)
                    }
                }
                
                // adding explicit spacing = 0 to avoid unexpected spacing anywhere
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(viewStore.name)
                                .font(.title)
                                .bold()
                            HStack(spacing: 0) {
                                Image(systemName: "dollarsign")
                                    .font(.headline)
                                Text("\(viewStore.price, specifier: "%.2f")")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .shadow(radius: 6)
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text(viewStore.startDate, style: .date)
                            Text("-")
                            if let endDate = viewStore.endDate {
                                Text(endDate, style: .date)
                            }
                            Spacer()
                        }
                        .font(.headline)
                        .fontWeight(.light)
                        .shadow(radius: 6)
                    }
                }
                .padding(10)
                
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Spacer ()
                        AsyncImage(url: viewStore.image) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame (maxWidth: (UIScreen.main.bounds.size.width - 30))
                                    .frame (height: 160)
                                    .cornerRadius (14)
                                    .shadow(radius: 12)
                            default:
                                ZStack {
                                    Color.white
                                    Text("Loading Party...")
                                        .font(.headline)
                                }
                                .frame (height: 250)
                                .cornerRadius (14)
                            }
                        }
                    }
                }
                .padding(.bottom, 5)
            }
            .frame (maxWidth: (UIScreen.main.bounds.size.width - 20))
            .frame (maxHeight: 250)
        }
        }
}

struct PartyCard_Previews: PreviewProvider {
    static var previews: some View {
        PartyCardView(
            store: Store(
                initialState: PartyCardReducer.State(
                    id: UUID(),
                    dataModel: .init( // mock data for preview
                        name: "Future's Concert",
                        bannerImage: URL(string: "https://images.unsplash.com/photo-1682685797742-42c9987a2c34?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!,
                        price: 65,
                        startDate: Date.now,
                        endDate: Date.now
                    )
                )
            ) {
                PartyCardReducer()
            }
        )
    }
}
