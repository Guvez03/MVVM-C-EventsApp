//
//  TitleSubtitleCellViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 4.05.2021.
//

import UIKit

final class TitleSubtitleCellViewModel{
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subtitle: String // neden private set kullandı
    private(set) var image: UIImage?
    let placeholder: String
    let type: CellType
    
    lazy var dateFormatter : DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yyy"
        return dateformatter
    }()
    
    init(title:String,subtitle:String,placeholder:String,type: CellType,onCellUpdate: (() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    var onCellUpdate: (() -> Void)?
    
    func update(_ subtitle:String){
        self.subtitle = subtitle
        
    }
    
    func update (_ date: Date){
        
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate?()
    }
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
