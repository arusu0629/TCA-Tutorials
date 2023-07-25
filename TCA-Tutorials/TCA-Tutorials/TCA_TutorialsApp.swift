//
//  TCA_TutorialsApp.swift
//  TCA-Tutorials
//
//  Created by af_nakandakari_toru on 2023/07/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_TutorialsApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            CounterView(store: TCA_TutorialsApp.store)
        }
    }
}
