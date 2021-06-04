//
//  UIImage+Extensions.swift
//  MVVM-C
//
//  Created by ahmet on 20.05.2021.
//

import UIKit

extension UIImage{
    func sameAspectRatio(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))  // yeni resim boyutunun yükseklik ve genişliği birbirine eşit olarak döner.
        }
    }
}
