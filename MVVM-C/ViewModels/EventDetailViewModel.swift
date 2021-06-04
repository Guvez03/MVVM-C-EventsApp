//
//  EventDetailViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 3.05.2021.
//

import Foundation
import UIKit
import CoreData

final class EventDetailViewModel {
    
    private let date = Date()
    private let eventID: NSManagedObjectID
    private let coreDataManager: CoreDataManager
    private var event: Event?
    var coordinator: EventDetailCoordinator?
    
    var onUpdate = {}
    
    var image: UIImage? {
        guard let imageData = event?.image else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemaningViewModel? {
        guard let eventDate = event?.date, let timeRemainingParts = date.timeRemaning(until: eventDate)?.components(separatedBy: ",") else {
            return nil
        }
        return TimeRemaningViewModel(timeRemaningParts: timeRemainingParts, mode: .detail)
    }
    
    init(eventID: NSManagedObjectID, coreDataManager: CoreDataManager = .shared) {
        self.eventID = eventID
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func reload() {
        event = coreDataManager.getEvent(eventID)
        onUpdate()
    }
    
    @objc func editButtonTapped() {
        guard let event = self.event else {
            return
        }
        coordinator?.onEditEvent(event: event)
    }
}
