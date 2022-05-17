//
//  OnboardingCell.swift
//  login
//
//  Created by brad on 2022/05/18.
//

import Foundation
import UIKit
import SnapKit


class OnboardingCell: UICollectionViewCell {
    
    static var identifier:String {return "\(self)" }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let stepLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
    
    private func setupView()
    {
        contentView.addSubview(imageView)
        contentView.addSubview(stepLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(CGFloat(contentView.frame.width * 0.93))
        }
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 60
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        imageView.clipsToBounds = true

        
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat(20))
            make.left.equalTo(contentView).offset(CGFloat(32))
            make.right.equalTo(contentView).offset(CGFloat(-10))
        }
        stepLabel.font = .systemFont(ofSize: CGFloat(15), weight: .bold)
        stepLabel.textColor =  UIColor.init(rgb: 0xDEDEDE)
        stepLabel.numberOfLines = 0
        stepLabel.textAlignment = .left
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(CGFloat(14))
            make.left.equalTo(stepLabel)
            make.right.equalTo(contentView).offset(CGFloat(-32))
        }
        titleLabel.font = .systemFont(ofSize: CGFloat(20), weight: .regular)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat(26))
            make.left.equalTo(titleLabel)
            make.right.equalTo(contentView).offset(CGFloat(-32))
        }
        descriptionLabel.font = .systemFont(ofSize: CGFloat(13), weight: .regular)
        descriptionLabel.textColor = UIColor.init(rgb: 0xAAAAAA)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
    }
    
    func bind(_ onboarding: OnboardingModel) {
        
        imageView.image = UIImage(named: onboarding.imageNamed)
        stepLabel.text = onboarding.step
        titleLabel.text = onboarding.title
        descriptionLabel.text = onboarding.description
    }
    
    
    
    
    
    
}

