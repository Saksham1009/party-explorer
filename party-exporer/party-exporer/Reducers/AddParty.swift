//
//  AddParty.swift
//  party-exporer
//
//  Created by Saksham Dua on 2023-12-03.
//

import ComposableArchitecture
import SwiftUI

public struct AddPartyReducer: Reducer {
    public struct State: Equatable {
        var name: String
        var bannerImage: URL
        var price: String = ""
        var startDate: Date = Date()
        var endDate: Date = Date()
        var showEndDate: Bool = false
        
        public init(
            name: String,
            bannerImage: URL
        ) {
            self.name = name
            self.bannerImage = bannerImage
        }
    }
    
    public enum Action {
        case setPrice(String)
        case setStartDate(Date)
        case setEndDate(Date)
        case showEndDate
        case publishParty(PartyModel)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .setPrice(let price):
                state.price = price
                return .none
            case .setStartDate(let date):
                state.startDate = date
                return .none
            case .showEndDate:
                state.showEndDate = true
                return .none
            case .setEndDate(let date):
                state.endDate = date
                return .none
            case .publishParty:
                return .none
            }
        }
    }
}

struct AddPartyView: View {
    
    let store: StoreOf<AddPartyReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    AsyncImage(url: viewStore.bannerImage) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame (height: 250)
                                .cornerRadius (14)
                        default:
                            ZStack {
                                Color.white
                                Text("Loading Image...")
                                    .font(.headline)
                            }
                            .frame (height: 250)
                            .cornerRadius (14)
                        }
                    }
                } header: {
                    Text("Banner")
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Text(viewStore.name)
                } header: {
                    Text("Title")
                }
                
                Section {
                    TextField(
                        "Enter price",
                        text: viewStore.binding(
                            get: \.price,
                            send: AddPartyReducer.Action.setPrice
                        )
                    )
                    .keyboardType(.decimalPad)
                } header: {
                    Text("Price")
                }
                
                Section {
                    VStack(spacing: 10) {
                        DatePicker(
                            "Start",
                            selection: viewStore.binding(
                                get: \.startDate,
                                send: AddPartyReducer.Action.setStartDate
                            ),
                            displayedComponents: [.date]
                        )
                        if (viewStore.showEndDate) {
                            DatePicker(
                                "End",
                                selection: viewStore.binding(
                                    get: \.endDate,
                                    send: AddPartyReducer.Action.setEndDate
                                ),
                                displayedComponents: [.date]
                            )
                        } else {
                            Button {
                                viewStore.send(.showEndDate)
                            } label: {
                                HStack(spacing: 0) {
                                    Text("Add End Date")
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(
                                    Color.blue
                                )
                                .cornerRadius(10)
                            }
                        }
                    }
                } header: {
                    Text("Start & End Date")
                }
                
                Button {
                    viewStore.send(
                        .publishParty(
                            .init(
                                name: viewStore.name,
                                bannerImage: viewStore.bannerImage,
                                price: Double(viewStore.price) ?? 0,
                                startDate: viewStore.startDate,
                                endDate: viewStore.showEndDate ? viewStore.endDate : nil
                            )
                        )
                    )
                } label: {
                    HStack(spacing: 0) {
                        Spacer()
                        Text("Submit")
                        Spacer()
                    }
                    .padding(15)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [.pink, .purple]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
                }
                .listRowBackground(Color.clear)
            }
        }
    }
}

struct AddParty_Previews: PreviewProvider {
    static var previews: some View {
        AddPartyView(
            store: Store(
                initialState: AddPartyReducer.State(
                    name: "Testing Here",
                    bannerImage: URL(string: "https://images.unsplash.com/photo-1682685797742-42c9987a2c34?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
                )
            ) {
                AddPartyReducer()
            }
        )
    }
}
