//
//  HeaderView.swift
//  Movies
//
//  Created by Softsuave on 16/09/2023.
//

import UIKit

protocol ExapandableHeaderViewdelegate {
    func toggeleSection(header: HeaderView, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {
    //MARK: - Variables
    var delegate: ExapandableHeaderViewdelegate?
    private lazy var arrowImage: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "rigth_arrow_image"))
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
    var section: Int!
    
    //MARK: - Override functions
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(arrowImage)
        setupConstraints()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.addSubview(arrowImage)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.gray
    }
    
    //MARK: - Other functions
    /// Setting constraints for arrow image
    private func setupConstraints() {
            let margin = contentView.layoutMarginsGuide
            
            NSLayoutConstraint.activate([
                arrowImage.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 10),
                arrowImage.topAnchor.constraint(equalTo: margin.topAnchor, constant: 0),
                arrowImage.widthAnchor.constraint(equalToConstant: 30),
                arrowImage.heightAnchor.constraint(equalToConstant: 30),
            ])
        }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! HeaderView
        delegate?.toggeleSection(header: self, section: cell.section)
    }
    
    /// Setting initial value of a view
    /// - Parameters:
    ///   - title: Title of the header
    ///   - section: section of header
    ///   - delegate: delegate for call back
    func customIniit(title: String, section: Int, delegate: ExapandableHeaderViewdelegate) {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
   
}
