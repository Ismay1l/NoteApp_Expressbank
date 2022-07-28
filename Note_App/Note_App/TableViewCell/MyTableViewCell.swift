//
//  MyTableViewCell.swift
//  Note_App
//
//  Created by Ismayil Ismayilov on 27.07.22.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: "colorSet2")
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: "colorSet2")
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(noteLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(8)
        }
        
        noteLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(headerLabel.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-5)
        }
    }
}
