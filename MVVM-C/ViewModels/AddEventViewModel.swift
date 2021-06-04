//
//  AddEventViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 3.05.2021.
//

import UIKit

final class AddEventViewModel{
    
    let title = "Add"
    
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubTitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    weak var coordinator: AddEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    
    private let cellBuilder : EventsCellBuilder
    private let coreDataManager: CoreDataManager
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    enum Mode {
        case add
        case edit(Event)
    }
    
    init(cellBuilder: EventsCellBuilder , coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad(){
        setupCells()
        onUpdate()
    }
    
    func viewDisAppear(){
        
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell{
        
        return cells[indexPath.row]
        
    }
    func tappedDoneBtn() {

        guard let name = nameCellViewModel?.subtitle, let dateString = dateCellViewModel?.subtitle, let image = backgroundImageCellViewModel?.image, let date = dateFormatter.date(from: dateString) else {
            return
        }
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
        
    }
    
    func updateCell(indexPath: IndexPath,subtitle:String){
        switch  cells[indexPath.row] {
        case .titleSubTitle(let titleSubTitleCellViewModel):
            titleSubTitleCellViewModel.update(subtitle)
        }
    }
    func didSelectRow(at indexPath:IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubTitle(let titleSubtitleCellViewModel):
            guard  titleSubtitleCellViewModel.type == .image else {
                return
            }
            coordinator?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image)
            }
        }
    }

    
}
private extension AddEventViewModel {
    
    func setupCells(){
        
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in 
            self?.onUpdate()
        }
        
        guard  let nameCellViewModel = nameCellViewModel ,let dateCellViewModel = dateCellViewModel ,let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        
        cells = [
            .titleSubTitle(nameCellViewModel),
            .titleSubTitle(dateCellViewModel),
            .titleSubTitle(backgroundImageCellViewModel)
        ]
        
    }
    
}
