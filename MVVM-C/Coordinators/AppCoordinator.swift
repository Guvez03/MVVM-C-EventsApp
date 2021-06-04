//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by ahmet on 2.05.2021.
//

import UIKit

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] {get}  // ???
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}
extension Coordinator {
    func childDidFinish(_ childCoordinator: Coordinator) {}
}

final class AppCoordinator :Coordinator{
    private(set) var childCoordinators: [Coordinator] = [] // ??? set // Herkes tarafından erişilebilir ancak değiştirilemez olmasını sağlar.
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        
        childCoordinators.append(eventListCoordinator)
        
        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}
