//
//  ContactsFeatureTests.swift
//  TCA-TutorialsTests
//
//  Created by af_nakandakari_toru on 2023/07/27.
//

import ComposableArchitecture
import XCTest

@testable import TCA_Tutorials

@MainActor
final class ContactsFeatureTests: XCTestCase {
    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }

        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                )
            )
        }
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
            $0.$destination[case: /ContactsFeature.Destination.State.addContact]?.contact.name = "Blob Jr."

        }
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        await store.receive(
            .destination(
                .presented(.addContact(.delegate(.saveContact(Contact(id: UUID(0), name: "Blob Jr.")))))
            )
        ) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")]
        }
        await store.receive(.destination(.dismiss)) {
            $0.destination = nil
        }
    }
}
