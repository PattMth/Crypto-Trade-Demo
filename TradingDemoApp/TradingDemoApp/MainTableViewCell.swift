//
//  MainTableViewCell.swift
//  CryptoTracker
//
//  Created by user189998 on 5/17/21.
//

import UIKit
struct MainTableViewCellViewModel {
    let name:String
    let symbol: String
    let price: String
    
}
class MainTableViewCell: UITableViewCell {
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private let abbrevLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(abbrevLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.sizeToFit()
        abbrevLabel.sizeToFit()
        priceLabel.sizeToFit()
            
        nameLabel.frame = CGRect(x: 10,y: 0, width: contentView.frame.size.width/2,height: contentView.frame.size.height/2)
        abbrevLabel.frame = CGRect(x: 10,y: contentView.frame.size.height/2, width: contentView.frame.size.width/2,height: contentView.frame.size.height/2)
        priceLabel.frame = CGRect(x: contentView.frame.size.width/1.4 ,y: 0, width: (contentView.frame.size.width/1.4)-5,height: contentView.frame.size.height/2)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        abbrevLabel.text = nil
    }
    func configure(with viewModel: MainTableViewCellViewModel){
        nameLabel.text = viewModel.name
        abbrevLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
    }
}
