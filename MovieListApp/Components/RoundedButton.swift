//
//  RoundedButton.swift
//  MovieListApp
//
//  Created by daniel.avram on 25/11/2020.
//

import UIKit

class RoundedButton: UIButton {

    private let highlightView: UIView = .init(frame: .zero)

    override var isHighlighted: Bool {
        didSet { didSetHighlighted() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        highlightView.isUserInteractionEnabled = false
        highlightView.pinToWholeArea(of: self)
        highlightView.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        toggleHighlightView(visible: false)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.height
        highlightView.layer.cornerRadius = layer.cornerRadius
        bringSubviewToFront(highlightView)
    }

    private func toggleHighlightView(visible: Bool) {
        highlightView.alpha = visible ? 1 : 0
    }

    private func toggleHighlightViewAnimated(visible: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.toggleHighlightView(visible: visible)
        }
    }

    private func didSetHighlighted() {
        toggleHighlightViewAnimated(visible: isHighlighted)
    }

}
