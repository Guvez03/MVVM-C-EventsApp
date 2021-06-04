//
//  TimeRemainingStackView.swift
//  MVVM-C
//
//  Created by ahmet on 20.05.2021.
//

import UIKit

final class TimeRemaningStackView: UIStackView {
    private let timeRemaningLabels = [UILabel(),UILabel(),UILabel(),UILabel()]
    
    func setup(){
        timeRemaningLabels.forEach{
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func update(with viewModel: TimeRemaningViewModel) {
        timeRemaningLabels.forEach{
            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize,weight:.medium)
            $0.textColor = .white
        }
        
        viewModel.timeRemaningParts.enumerated().forEach{
            timeRemaningLabels[$0.offset].text = $0.element  // bu nedir bilmiyorum
        }
        

        alignment = viewModel.allignment
    }
}
