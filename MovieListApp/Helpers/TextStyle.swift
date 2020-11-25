//
//  TextStyle.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

struct TextStyle {
    let font: UIFont
    let color: UIColor
}

extension UILabel {

    func set(textStyle: TextStyle) {
        font = textStyle.font
        textColor = textStyle.color
    }

}

extension UIButton {

    func set(textStyle: TextStyle) {
        titleLabel?.font = textStyle.font
        setTitleColor(textStyle.color, for: .normal)
    }

}
