//
//  MyTableViewCell.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    lazy var image =  UIImageView()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI() {
        self.contentView.addSubview(headerLabel)
        self.contentView.addSubview(noteLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(2)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(headerLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-5)
        }
    }
}
