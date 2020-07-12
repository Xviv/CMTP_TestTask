//
//  NewsTableCell.swift
//  CMTP_TestTask
//
//  Created by Dan on 12.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableCell: UITableViewCell {
    
    //MARK: - Properties
    
    var model: NewsResult? {
        didSet {
            guard let model = model else { return }
            setLabels(for: model.webTitle)
            guard let url = URL(string: model.fields?.thumbnail ?? "") else { return }
            newsImageView.sd_setImage(with: url)
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Reuse
    
    override func prepareForReuse() {
        newsImageView.sd_cancelCurrentImageLoad()
        newsImageView.image = nil
        subviews.forEach({
            if let label = $0 as? UILabel {
                label.removeFromSuperview()
            }
        })
    }
    
    //MARK: - UI Components
    
    let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemYellow
        return imageView
    }()
    
    //MARK: - UI Setup
    
    private func setupUI() {
        addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor),
            newsImageView.leftAnchor.constraint(equalTo: leftAnchor),
            newsImageView.rightAnchor.constraint(equalTo: rightAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setLabels(for text: String) {
        
        let maxLabelWidth: CGFloat = self.frame.width - 48
        let font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let spaceWidth = NSString(string: " ").size(withAttributes: [NSAttributedString.Key.font: font]).width
        
        
        var currentRowWidth: CGFloat = 0
        var currentRow = ""
        var prevLabel: UILabel?
        
        let subStrings = text.split(separator: " ")
        for subString in subStrings {
            let currentWord = String(subString)
            let nsCurrentWord = NSString(string: currentWord)
            
            let currentWordWidth = nsCurrentWord.size(withAttributes: [NSAttributedString.Key.font: font]).width
            
            let currentWidth = currentRow.count == 0 ? currentWordWidth : currentWordWidth + spaceWidth + currentRowWidth
            
            if currentWidth <= maxLabelWidth {
                currentRowWidth = currentWidth
                currentRow += currentRow.count == 0 ? currentWord : " " + currentWord
            } else {
                prevLabel = generateLabel(with: currentRow,
                                          font: font,
                                          prevLabel: prevLabel)
                currentRowWidth = currentWordWidth
                currentRow = currentWord
            }
        }
        
        generateLabel(with: currentRow,
                      font: font,
                      prevLabel: prevLabel)
    }
    
    @discardableResult private func generateLabel(with text: String,
                                                  font: UIFont,
                                                  prevLabel: UILabel?) -> UILabel {
        let leftPadding: CGFloat = 24
        let topPadding: CGFloat = 24
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding).isActive = true
        if let prevLabel = prevLabel {
            label.topAnchor.constraint(equalTo: prevLabel.bottomAnchor).isActive = true
        } else {
            label.topAnchor.constraint(equalTo: topAnchor, constant: topPadding).isActive = true
        }
        
        label.font = font
        label.text = text
        label.textColor = .white
        label.backgroundColor = .black
        
        return label
    }
}
