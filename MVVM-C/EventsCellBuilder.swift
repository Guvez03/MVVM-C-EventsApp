//
//  EventsCellBuilder.swift
//  MVVM-C
//
//  Created by ahmet on 12.05.2021.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType,onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel{
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(title: "Ad", subtitle: "", placeholder: "Adınızı giriniz.",type: .text,onCellUpdate: onCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel(title: "Tarih", subtitle: "", placeholder: "Tarih Seçiniz",type: .date,onCellUpdate:onCellUpdate)
        case .image:
            return TitleSubtitleCellViewModel(title: "Background", subtitle: "", placeholder: "",type: .image,onCellUpdate: onCellUpdate)
            
        }
        
    }
}
