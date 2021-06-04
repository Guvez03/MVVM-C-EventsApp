//
//  EventCellViewModel.swift
//  MVVM-C
//
//  Created by ahmet on 18.05.2021.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
//    var yearText: String {
//        "1 year"
//    }
//    var monthText: String {
//        "2 month"
//    }
//    var weekText: String {
//        "1 week"
//    }
//    var dayText: String {
//        "3 days"
//    }
    
    static let imageCache = NSCache<NSString,UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue",qos: .background)
    var onSelect: (NSManagedObjectID) -> Void = {_ in}
    
    private var cacheKey: String {
        event.objectID.description // kaydedilen verinin ıd sini alırız.
    }
    
    let date = Date()
    
    var timeRemaningStrings: [String] {
        guard let eventDate = event.date else {
            return []
        }
        return date.timeRemaning(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    var dateText: String {
        guard let eventDate = event.date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)

    }
    var eventName: String? {
        event.name
    }
    
    var timeRemaningViewModel: TimeRemaningViewModel? {
        guard let eventDate = event.date, let timeRemaningParts = date.timeRemaning(until: eventDate)?.components(separatedBy: ",") else {return nil}
        return TimeRemaningViewModel(timeRemaningParts: timeRemaningParts, mode: .cell)
    }
    
    // imageleri böyle aldığımızda scroll sırasında gecikmeler oluyor bunun için image caching kullanılabilir.
//    var backgroundImage: UIImage {
//        guard let imageData = event.image else {return UIImage()}
//        return UIImage(data: imageData) ?? UIImage()
//    }
    
    // image Caching
    func loadImage(completion: @escaping(UIImage?) ->Void) {
        if let image =  Self.imageCache.object(forKey: cacheKey as NSString) {  // eğer cachede image varsa getirir ve completiona gönderir yoksa kaydeder
            completion(image)
        }else {
            
            imageQueue.async {
                guard let imageData = self.event.image , let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
   
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
            }
        }
    }
    func didSelect(){
        onSelect(event.objectID)
    }
    
    
    private let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
    
}
