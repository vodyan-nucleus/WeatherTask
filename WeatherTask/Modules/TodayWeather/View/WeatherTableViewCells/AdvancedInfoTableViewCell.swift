//
//  AdvancedInfoTableViewCell.swift
//  WeatherTask
//
//  Created by Евгений Водянович on 15.10.2021.
//

import UIKit

protocol AdvancedInfoCellProtocol {
    func display(param: String, value: String)
}


class AdvancedInfoTableViewCell: UITableViewCell {
    
    static let identifier = "AdvancedInfoTableViewCell"
    
    var paramLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)
        label.textColor = .lightText
        label.text = "ВОСХОД СОЛНЦА"
        return label
    }()
    
    var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.text = "10 %"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubview(paramLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            paramLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant: 5),
            paramLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            valueLabel.topAnchor.constraint(equalToSystemSpacingBelow: paramLabel.bottomAnchor, multiplier: 0.3),
            valueLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
}

extension AdvancedInfoTableViewCell: AdvancedInfoCellProtocol {
    func display(param: String, value: String) {
        paramLabel.text = param
        valueLabel.text = value
    }
}
