//
//  CryptoTableViewCell.swift
//  CryptoTracker
//
//  Created by user189998 on 5/12/21.
//

import UIKit
class CryptoTableViewCellViewModel {
    let name:String
    let symbol: String
    let price: String
    let iconUrl: URL?
    var iconData: Data?
    
    init(name:String,
    symbol: String,
    price: String,
    iconUrl: URL?) {
        self.name = name
        self.symbol = symbol
        self.price = price
        self.iconUrl = iconUrl
    }
}

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    //set uilabels
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
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
//create subviews of view
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(abbrevLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }//set layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height/1.1
        iconImageView.frame = CGRect(
            x: 20,
            y: (contentView.frame.size.height-size)/2,
            width: size,
            height: size
        )
        
        nameLabel.sizeToFit()
        abbrevLabel.sizeToFit()
        priceLabel.sizeToFit()
            
        nameLabel.frame = CGRect(x: 30+size,y: 0, width: contentView.frame.size.width/2,height: contentView.frame.size.height/2)
        abbrevLabel.frame = CGRect(x: 30+size,y: contentView.frame.size.height/2, width: contentView.frame.size.width/2,height: contentView.frame.size.height/2)
        priceLabel.frame = CGRect(x: contentView.frame.size.width/1.4 ,y: 0, width: (contentView.frame.size.width/1.4)-5,height: contentView.frame.size.height/2)
        
    }
    //delete datas when iterating
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        abbrevLabel.text = nil
    }
    //config labels
    func configure(with viewModel: CryptoTableViewCellViewModel){
        nameLabel.text = viewModel.name
        abbrevLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        if let data = viewModel.iconData{
            iconImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.iconUrl{
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    viewModel.iconData = data
                    DispatchQueue.main.async {
                        self.iconImageView.image = UIImage(data: data)
                    }
                }
                
            }
            task.resume()
            
        }
    }
}
