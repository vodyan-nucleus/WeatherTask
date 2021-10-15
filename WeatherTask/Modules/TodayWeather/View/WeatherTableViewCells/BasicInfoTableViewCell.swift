//
//  BasicInfoTableViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

protocol BasicInfoCellProtocol {
    func display(location: String, description: String, currentTemperature: String, feelsLikeTemp: String)
}

class BasicInfoTableViewCell: UITableViewCell {
    
    static let identifier = "BasicInfoTableViewCell"
    
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Варшава"
        label.font = label.font.withSize(35)
        label.textColor = .white
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Приемущественно облачно"
        label.font = label.font.withSize(17)
        label.textColor = .white
        return label
    }()
    
    var currentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 90.0)
        label.text = "17º"
        label.textColor = .white
        return label
    }()
    
    var maxMinTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(17)
        label.text = "Max 18º, min 7º"
        label.textColor = .white
        return label
    }()
    
    var basicInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 0
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setLayout()
    }
    
    private func setLayout() {
        basicInfoStackView.addArrangedSubview(locationLabel)
        basicInfoStackView.addArrangedSubview(descriptionLabel)
        basicInfoStackView.addArrangedSubview(currentTempLabel)
        basicInfoStackView.addArrangedSubview(maxMinTempLabel)
        addSubview(basicInfoStackView)
        NSLayoutConstraint.activate([
            basicInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            basicInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BasicInfoTableViewCell: BasicInfoCellProtocol {
    func display(location: String, description: String, currentTemperature: String, feelsLikeTemp: String) {
        locationLabel.text = location
        descriptionLabel.text = description
        currentTempLabel.text = currentTemperature
        maxMinTempLabel.text = feelsLikeTemp
    }
}
