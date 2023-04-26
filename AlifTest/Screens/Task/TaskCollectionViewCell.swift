//
//  TaskCollectionViewCell.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

protocol TaskCollectionCellDelegate: AnyObject {
    func isCompleted(taskName: String)
    func cancelDone(taskName: String)
}

class TaskCollectionViewCell: UICollectionViewCell {
    
    static let indentifire = "TaskItem" 
    var delegate: TaskCollectionCellDelegate?
    
    var isCompleted: Bool?
    
    lazy var taskLabel = InfoLabels(inform: "", size: 17, weight: .semibold, color: .black)
    lazy var dateLabel = InfoLabels(inform: "", size: 15, weight: .regular, color: .black)
    lazy var executorLabel = InfoLabels(inform: "", size: 13, weight: .semibold, color: .systemGray)
    lazy var circleImage = CustomSystemImageView(systemName: "circle", color: .buttonColor)
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.setupView()
        self.addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: Task) {
       
        self.taskLabel.text = viewModel.taskName
        self.dateLabel.text = "Выполнить к " + dateFormatter.string(from: viewModel.deadline!)
        self.executorLabel.text = "Исполнитель: \(viewModel.executor ?? "")"
        
    }
    func addGesture() {
        let circleGesture = UITapGestureRecognizer(target: self, action: #selector(circleTap))
        self.circleImage.addGestureRecognizer(circleGesture)
    }
    @objc func circleTap() {
        print("pushCircle")
        let taskName = self.taskLabel.text
        guard let isCompleted else { return }
        
        if isCompleted {
            self.delegate?.cancelDone(taskName: taskName ?? "")
        } else {
            self.delegate?.isCompleted(taskName: taskName ?? "")
        }
    }
    
    private func setupView() {
        self.contentView.addSubview(taskLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(executorLabel)
        self.contentView.addSubview(circleImage)
        self.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            self.taskLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.taskLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.taskLabel.bottomAnchor,constant: 4),
            self.dateLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 20),
            
            self.executorLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 30),
            self.executorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.executorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            self.circleImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.circleImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -25),
            self.circleImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.11078),
            self.circleImage.heightAnchor.constraint(equalTo: self.circleImage.widthAnchor),
            
        ])
    }
}


