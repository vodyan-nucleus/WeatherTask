//
//  DailyForecastTableViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 17.10.2021.
//

import UIKit

protocol DailyForecastCellProtocol {
    func display(time: String, description: String, temperature: String, image: String)
}

class DailyForecastTableViewCell: UITableViewCell{
    
    static let identifier = "BasicInfoTableViewCell"
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "12:00"
        label.font = label.font.withSize(17)
        label.textColor = .white
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Ясно"
        label.font = label.font.withSize(13)
        label.textColor = .white
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "17º"
        label.font = label.font.withSize(35)
        label.textColor = .white
        return label
    }()
    
    var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "01d")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var basicInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white.withAlphaComponent(0.3)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        contentView.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        basicInfoStackView.addArrangedSubview(timeLabel)
        basicInfoStackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(basicInfoStackView)
        NSLayoutConstraint.activate([
            basicInfoStackView.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 30),
            basicInfoStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension DailyForecastTableViewCell: DailyForecastCellProtocol {
    func display(time: String, description: String, temperature: String, image: String) {
        timeLabel.text = time
        descriptionLabel.text = description
        tempLabel.text = temperature
        iconImage.image = UIImage(named: "\(image)")
    }
}
