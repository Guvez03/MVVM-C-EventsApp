//
//  EventListViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 3.05.2021.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    
    enum Cell{
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    private var coreDataManager: CoreDataManager
    
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad(){
        reload()
    }
    
    func reload(){
        EventCellViewModel.imageCache.removeAllObjects()
        let events = coreDataManager.fetchEvents()
        //cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
        }
        onUpdate()
    }
    
    func tappedAddEvent(){
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        
        return cells.count
    }
    
    func cell (at indexPath: IndexPath) -> Cell {
        
        return cells[indexPath.row]
        
    }
    func didSelectRowAt(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
    
}
