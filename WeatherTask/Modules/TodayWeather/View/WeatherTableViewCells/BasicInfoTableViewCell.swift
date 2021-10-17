//
//  BasicInfoTableViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

protocol BasicInfoCellProtocol {
    func display(iconName: String, location: String, currentTemperatureAndDescription: String)
}

class BasicInfoTableViewCell: UITableViewCell {
    
    static let identifier = "BasicInfoTableViewCell"
    
    var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Варшава"
        label.font = label.font.withSize(22)
        label.textColor = .white
        return label
    }()
    
    var currentTempAndDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        label.text = "17º"
        label.textColor = .white
        return label
    }()
    
    var basicInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white.withAlphaComponent(0.3)
        isUserInteractionEnabled = true
        setLayout()
    }
    
    private func setLayout() {
        basicInfoStackView.addArrangedSubview(iconImage)
        basicInfoStackView.addArrangedSubview(locationLabel)
        basicInfoStackView.addArrangedSubview(currentTempAndDescriptionLabel)
        addSubview(basicInfoStackView)
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 100),
            iconImage.heightAnchor.constraint(equalToConstant: 100),
            basicInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            basicInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        contentView.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 33),
            sendButton.heightAnchor.constraint(equalToConstant: 38),
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BasicInfoTableViewCell: BasicInfoCellProtocol {
    func display(iconName: String, location: String, currentTemperatureAndDescription: String) {
        iconImage.image = UIImage(named: iconName)
        locationLabel.text = location
        currentTempAndDescriptionLabel.text = currentTemperatureAndDescription
    }
}
