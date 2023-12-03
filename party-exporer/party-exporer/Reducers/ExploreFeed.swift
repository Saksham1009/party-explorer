//
//  ExploreFeed.swift
//  party-exporer
//
//  Created by Saksham Dua on 2023-12-03.
//

import ComposableArchitecture
import SwiftUI

public struct ExploreFeedReducer: Reducer {
    public struct State: Equatable {
        var partyList: [PartyCardReducer.State]
        var filteredPartyList: [PartyCardReducer.State] // Added this to keep the filtering logic out of the view part
        var searchText: String = ""
        var partyCreaterPresented = false
        var createParty: AddPartyReducer.State?
        
        public init(
            partyList: [PartyCardReducer.State]
        ) {
            self.partyList = partyList
            self.filteredPartyList = partyList
        }
    }
    
    public enum Action {
        case addPartyTapped
        case newPartyPresentationDismiss
        case searchTextUpdate(String)
        case createParty(AddPartyReducer.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addPartyTapped:
                state.searchText = ""
                state.createParty = AddPartyReducer.State(
                    name: getRandomName(),
                    bannerImage: URL(string: getRandomImage())!
                )
                state.partyCreaterPresented = true
                return .none
            case .searchTextUpdate(let searchInput):
                state.searchText = searchInput
                state.filteredPartyList = state.partyList.filter({ partyCard in
                    return state.searchText == "" || partyCard.name.lowercased().contains(state.searchText.lowercased())
                })
                return .none
            case .createParty(.publishParty(let newParty)):
                state.partyCreaterPresented = false
                state.partyList.append(PartyCardReducer.State(id: UUID(), dataModel: newParty))
                state.filteredPartyList = state.partyList
                return .none
            case .createParty:
                return .none
            case .newPartyPresentationDismiss:
                state.partyCreaterPresented = false
                return .none
            }
        }
        .ifLet(\.createParty, action: /Action.createParty) {
            AddPartyReducer()
        }
    }
}

struct ExploreFeedView: View {
    
    let store: StoreOf<ExploreFeedReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack(spacing: 0) {
                    TextField(
                        "Search Parties...",
                        text: viewStore.binding(
                            get: \.searchText,
                            send: ExploreFeedReducer.Action.searchTextUpdate
                        )
                    )
                    Button {
                        viewStore.send(.addPartyTapped)
                    } label: {
                        HStack(spacing: 0) {
                            Image(systemName: "party.popper")
                            Text("Add Party")
                        }
                        .padding(5)
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
                        .cornerRadius(40)
                    }
                }
                .padding()
                if (viewStore.filteredPartyList.count > 0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(viewStore.filteredPartyList) { partyCard in
                            PartyCardView(
                                store: Store(initialState: partyCard) {
                                    PartyCardReducer()
                                }
                            )
                        }
                    }
                } else {
                    Spacer()
                    Text("Sorry, no matching parties yet :(")
                        .font(.headline)
                    Spacer()
                }
            }
            .sheet(isPresented: viewStore.binding(get: \.partyCreaterPresented, send: ExploreFeedReducer.Action.newPartyPresentationDismiss)) {
                IfLetStore(
                    store.scope(
                        state: \.createParty,
                        action: { .createParty($0) }
                    ),
                    then: {
                        AddPartyView(store: $0)
                    }
                )
            }
        }
    }
}

struct ExploreFeed_Previews: PreviewProvider {
    static var previews: some View {
        ExploreFeedView(
            store: Store(
                initialState: ExploreFeedReducer.State(
                    partyList: [
                        .init( // mock data for preview
                            id: UUID(),
                            dataModel: .init(
                                name: "Glow in dark bar",
                                bannerImage: URL(string: "https://images.unsplash.com/photo-1682685797742-42c9987a2c34?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!,
                                price: 45.99,
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
