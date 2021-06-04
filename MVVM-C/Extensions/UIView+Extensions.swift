//
//  UIView+Extensions.swift
//  MVVM-C
//
//  Created by ahmet on 18.05.2021.
//

import UIKit

enum Edge {
    case left
    case right
    case bottom
    case top
}

extension UIView {

    func pinToSuperViewEdges(_ edges: [Edge] = [.top,.left,.right,.bottom], constant: CGFloat = 0) {
        guard let superview = superview else { return}
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor,constant: constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor,constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor,constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor,constant: -constant).isActive = true
            }
        }
    }
    
}
