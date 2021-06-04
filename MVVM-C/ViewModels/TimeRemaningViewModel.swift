//
//  TimeRemaningViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 20.05.2021.
//

import UIKit

final class TimeRemaningViewModel {
    
    enum Mode {
        case cell
        case detail
    }
    
    let timeRemaningParts: [String]
    private let mode: Mode
    
    init(timeRemaningParts: [String], mode: Mode) {
        self.timeRemaningParts = timeRemaningParts
        self.mode = mode
    }
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:
            return 25
        case .detail:
            return 50
        }
    }
    
    var allignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
}
