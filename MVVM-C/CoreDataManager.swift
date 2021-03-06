//
//  CoreDataManager.swift
//  MVVM-C
//
//  Created by ahmet on 2.05.2021.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // persistent container ? nedir
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func getEvent(_ id: NSManagedObjectID)-> Event?{
        do{
            return try moc.existingObject(with: id) as? Event
            
        }catch{
            print(error)
        }
        return nil
    }
    
    func saveEvent(name: String,date: Date,image: UIImage){
                
        let event = Event(context: moc) // coredata entity name
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        do{
            try moc.save()
        }catch{
            print(error)
        }
        
    }
    
    public func updateEvent(event: Event, name: String, date: Date, image: UIImage) {
        event.setValue(name, forKey: "name")
        event.setValue(date, forKey: "date")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    func fetchEvents() -> [Event] {
        do{
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event") // generic types
            let events = try moc.fetch(fetchRequest)
            return events
        }catch{
            print(error)
            return []
        }
    }
    
    
}
