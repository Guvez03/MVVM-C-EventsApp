//
//  AddEvenCoordinator.swift
//  MVVM-C
//
//  Created by ahmet on 3.05.2021.
//

import UIKit

final class AddEventCoordinator: Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController : UINavigationController
    var modalNavigationController: UINavigationController?
    var parentCoordinator : EventListCoordinator?
    var completion: (UIImage) -> Void = {_ in}
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        
        modalNavigationController = UINavigationController()
        let addEventViewController : AddEventViewController = .instantiate()
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)  // setViewController = Her bir denetleyiciyi açıkça zorlamadan veya açmadan geçerli görünüm denetleyici yığınını güncellemek veya değiştirmek için bu yöntem kullanılmuıştır.
        let addEventViewModel = AddEventViewModel(cellBuilder: EventsCellBuilder())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
        
    }
    
    func didFinish() {
        
        parentCoordinator?.childDidFinish(self)
    }
    func didFinishSaveEvent(){
        parentCoordinator?.onUpdateEvent()
        navigationController.dismiss(animated: true, completion: nil)
    }
    func showImagePicker(completion: @escaping(UIImage) -> Void){
        guard let modalNavigationController = modalNavigationController else{
            return
        }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
//        // YENii
//        imagePickerCoordinator.onFinishPicking = { [weak self] image in
//            completion(image)
//            self?.navigationController.dismiss(animated: true, completion: nil)
//        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishPicking(_ image:UIImage){

        completion(image)
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }){
            childCoordinators.remove(at: index)
        }
    }
    
}
