//
//  TaskCollectionViewCell.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
    
    static let indentifire = "TaskItem" 
    
    var indexPath: IndexPath?
    lazy var taskLabel = InfoLabels(inform: "", size: 17, weight: .semibold, color: .black)
    lazy var dateLabel = InfoLabels(inform: "", size: 12, weight: .regular, color: .systemGray2)
    lazy var executorLabel = InfoLabels(inform: "", size: 13, weight: .semibold, color: .systemGray)
    lazy var circleImage = CustomSystemImageView(systemName: "", color: .white)
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
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
    //var delegate: HabitsCollectionViewCellDelegate?.
    
    
    func setup(with viewModel: Task) {
       
        self.taskLabel.text = viewModel.taskName
        self.taskLabel.textColor = UIColor.color(data: viewModel.color!)
        self.dateLabel.text = "Каждый день в " + dateFormatter.string(from: viewModel.deadline!) //(viewModel.deadline)
        self.executorLabel.text = "Исполнитель: \(viewModel.executor ?? "")"
        self.circleImage.tintColor = UIColor.color(data: viewModel.color!)
        let color = UIColor.blue
//        let data = Data
    }
    func addGesture() {
        let circleGesture = UITapGestureRecognizer(target: self, action: #selector(circleTap))
        self.circleImage.addGestureRecognizer(circleGesture)
    }
    @objc func circleTap() {
        print("pushCircle")
//        self.delegate?.tapCircle(cell: self)
        
        
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


