//
//  ShadowedImageView.swift
//  MovieListApp
//
//  Created by daniel.avram on 26/11/2020.
//

import UIKit

class ShadowedImageView: UIImageView {

    private let contentImageView = UIImageView()

    override var image: UIImage? {
        didSet {
            contentImageView.image = image
            super.image = nil
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.pinToWholeArea(of: self)
        contentImageView.clipsToBounds = true
        clipsToBounds = false
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentImageView.layer.cornerRadius = 0.04 * bounds.width
        let shadowRect = CGRect(
            x: 1,
            y: bounds.height + 1,
            width: bounds.width - 2,
            height: 4
        )
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }

}
