//
//  TitleSubtitleCell.swift
//  MVVM-C
//
//  Created by ahmet on 4.05.2021.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    private let titleLabel  = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    private let constant:CGFloat = 15
    
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 100))
    lazy var doneButton :UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView = UIImageView()
    
    private var viewModel : TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierrachy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubtitleCellViewModel){

        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleTextField.placeholder = viewModel.placeholder
        subtitleTextField.text = viewModel.subtitle
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePicker
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
    
        subtitleTextField.isHidden = viewModel.type == .image
        photoImageView.isHidden = viewModel.type != .image
        
        photoImageView.image = viewModel.image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    
    func setupViews(){
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 18, weight: .medium)
        
        [verticalStackView,titleLabel,subtitleTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolbar.setItems([doneButton], animated: false)
        datePicker.datePickerMode = .date
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
    }
    func setupHierrachy(){
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    func setupLayout(){
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: constant),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: constant),
            verticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -constant)
        ])
        
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    @objc func tappedDone(){
        viewModel?.update(datePicker.date)
    }
    
}
