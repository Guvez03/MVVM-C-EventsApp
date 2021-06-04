//
//  EventDetailViewController.swift
//  MVVM-C
//
//  Created by ahmet on 20.05.2021.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var backgrounfImageView: UIImageView!
    @IBOutlet weak var timeRemaningStackView: TimeRemaningStackView! {
        didSet{
            timeRemaningStackView.setup()
        }
    }
    var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName:"pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self , let timeRemaningViewModel = self.viewModel.timeRemainingViewModel else {return}
            self.backgrounfImageView.image = self.viewModel.image
            self.timeRemaningStackView.update(with: timeRemaningViewModel)
        }

        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        viewModel.viewDidDisappear()
    }
    
}

