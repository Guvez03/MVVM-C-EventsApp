//
//  ImagePickerCoordinator.swift
//  MVVM-C
//
//  Created by ahmet on 12.05.2021.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController : UINavigationController
    
    var parentCoordinator: Coordinator?
    var onFinishPicking: (UIImage) -> Void = { _ in }
    
    init(navigationController:UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerContrroler = UIImagePickerController()
        imagePickerContrroler.delegate = self
        navigationController.present(imagePickerContrroler, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            onFinishPicking(image)

        }
        parentCoordinator?.childDidFinish(self)
    }
    
}
