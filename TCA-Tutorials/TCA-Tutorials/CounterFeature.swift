//
//  CounterFeature.swift
//  TCA-Tutorials
//
//  Created by af_nakandakari_toru on 2023/07/24.
//

import ComposableArchitecture

struct CounterFeature: ReducerProtocol {

    struct State {
        var count = 0
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}
