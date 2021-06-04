//
//  Date+Extension.swift
//  MVVM-C
//
//  Created by ahmet on 18.05.2021.
//

import Foundation

extension Date {
    func timeRemaning(until endDate: Date) -> String? {  // gelen tarihi yıl ay gün haftaya böler ve string olarak döndürür. Kalan süreyi verir.
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
}
