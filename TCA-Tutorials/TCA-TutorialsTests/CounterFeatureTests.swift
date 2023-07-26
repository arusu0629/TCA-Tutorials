//
//  CounterFeatureTests.swift
//  TCA-Tutorials
//
//  Created by af_nakandakari_toru on 2023/07/26.
//

@testable import TCA_Tutorials
import ComposableArchitecture
import XCTest

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }

        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
