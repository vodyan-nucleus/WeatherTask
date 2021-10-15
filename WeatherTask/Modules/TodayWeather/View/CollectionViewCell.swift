//
//  CollectionViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
   static let identifier = "CollectionViewCell"
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сейчас"
        label.textColor = .white
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15º"
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    var phraseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "039-sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var hourlyForecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 15
        return stackView
    }()
    
        override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(){
        hourlyForecastStackView.addArrangedSubview(timeLabel)
        hourlyForecastStackView.addArrangedSubview(phraseImage)
        hourlyForecastStackView.addArrangedSubview(tempLabel)
        addSubview(hourlyForecastStackView)
        
        NSLayoutConstraint.activate([
            phraseImage.heightAnchor.constraint(equalToConstant: 24),
            phraseImage.widthAnchor.constraint(equalToConstant: 24),
            
            hourlyForecastStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            hourlyForecastStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
