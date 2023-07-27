//
//  ContactsFeature.swift
//  TCA-Tutorials
//
//  Created by af_nakandakari_toru on 2023/07/27.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

struct ContactsFeature: ReducerProtocol {
    struct State: Equatable {
        @PresentationState var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    enum Action: Equatable {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none

            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none

            case .addContact(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact else { return .none }
                state.contacts.append(contact)
                state.addContact = nil
                return .none

            case .addContact:
                return .none
            }
        }
        .ifLet(\.$addContact, action: /Action.addContact) {
            AddContactFeature()
        }
    }
}

struct ContentView: View {
    let store: StoreOf<ContactsFeature>

    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        Text(contact.name)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: ContactsFeature.State(
                    contacts: [
                        Contact(id: UUID(), name: "Blob"),
                        Contact(id: UUID(), name: "Blob Jr"),
                        Contact(id: UUID(), name: "Blob Sr"),
                    ]
                ),
                reducer: ContactsFeature()
            )
        )
    }
}
