//
//  EditEventViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 20.05.2021.
//

import Foundation
import UIKit

final class EditEventViewModel {
    
    private(set) var cells: [EditEventViewModel.Cell] = []

    let title = "Edit"
    weak var coordinator: EditEventCoordinator?
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    var onUpdate: () -> Void = {}
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    
    private let cellBuilder: EventsCellBuilder
    private let coreDataManager: CoreDataManager
    private let event: Event
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    enum Mode {
        case add
        case edit(Event)
    }
    
    init(event: Event, cellBuilder: EventsCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle, let dateString = dateCellViewModel?.subtitle, let image = backgroundImageCellViewModel?.image, let date = dateFormatter.date(from: dateString) else {
            return
        }
        
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        coordinator?.didFinishUpdateEvent()
        
    }
    
    func updateText(forCellAt indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            coordinator?.showImagePicker(completion: { image in
                titleSubtitleCellViewModel.update(image)
            })
        }
    }
    
    deinit {
        print("deinit from AddEventViewModel")
    }
}

private extension EditEventViewModel {
    
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text, onCellUpdate: nil)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else {
            return
        }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]
        
        guard let name = event.name, let date = event.date, let imageData = event.image, let image = UIImage(data: imageData) else {
            return
        }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundImageCellViewModel.update(image)
        
    }
    
}
