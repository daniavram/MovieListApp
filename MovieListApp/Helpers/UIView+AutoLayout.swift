//
//  UIView+AutoLayout.swift
//  MovieListApp
//
//  Created by daniel.avram on 23/11/2020.
//

import UIKit

extension UIView {

    private func prepareForConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviewIfNeeded(_ subview: UIView) {
        guard
            subview.superview == nil,
            subviews.contains(subview) == false
        else {
            return
        }
        addSubview(subview)
    }

    func pinToWholeArea(
        of superView: UIView,
        withPadding padding: NSDirectionalEdgeInsets = .zero
    ) {
        prepareForConstraints()
        superView.addSubviewIfNeeded(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding.leading),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: padding.top),
            superView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.trailing),
            superView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom),
        ])
    }

    func pinToSafeArea(
        of superView: UIView,
        withPadding padding: NSDirectionalEdgeInsets = .zero
    ) {
        prepareForConstraints()
        superView.addSubviewIfNeeded(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: padding.leading),
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            superView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.trailing),
            superView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom),
        ])
    }

}
